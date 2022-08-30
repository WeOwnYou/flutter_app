import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/navigation/main_navigation.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_events.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_state.dart';
import 'package:flutter_app/core/domain/providers/image_provider.dart';
import 'package:flutter_app/core/service/firebase_data_service.dart';
import 'package:flutter_app/core/ui/handlers/error_handler.dart';
import 'package:flutter_app/core/ui/view_model/view_model.dart';

@immutable
class Question {
  final String question;
  final bool answer;
  final String? url;
  const Question({required this.answer, required this.question, this.url});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question &&
          runtimeType == other.runtimeType &&
          question == other.question &&
          answer == other.answer &&
          url == other.url;

  @override
  int get hashCode => question.hashCode ^ answer.hashCode ^ url.hashCode;

  Question copyWith({
    String? question,
    bool? answer,
    String? url,
  }) {
    return Question(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      url: url ?? this.url,
    );
  }
}

class HomeViewModel extends ViewModel {
  SimpleErrorHandler errorHandler;
  final BuildContext context;
  bool _isDragging = false;
  late Size _screenSize;
  double _angle = 0;
  Offset _position = Offset.zero;
  bool? _isGoingTrue;
  String _overlayMessage = '';
  HomeState _initialState = HomeState.data(const <Question>[]);
  HomeState _newState = HomeState.data(const []);
  late final Stream<HomeState> _stream;
  final StreamController<HomeEvent> _streamController =
      StreamController<HomeEvent>.broadcast();

  HomeState get initialState => _initialState;
  Stream<HomeState> get stream => _stream;
  bool? get isGoingTrue => _isGoingTrue;
  Offset get position => _position;
  double get angle => _angle;
  bool get isDragging => _isDragging;
  String get overlayMessage => _overlayMessage;

  HomeViewModel(this.context, this.errorHandler)
      : super(context, errorHandler: errorHandler);

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  void onInit() {
    super.onInit();
    _stream = _streamController.stream
        .asyncExpand<HomeState>(_mapEventToState)
        .asyncExpand<HomeState>(_updateState)
        .asBroadcastStream();
    _stream.listen((event) {});
    _streamController.add(InitializeEvent());
  }

  Stream<HomeState>? _mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case InitializeEvent:
        await _loadData();
        yield const HomeState().copyWith(
          questions: _newState.questions,
          isLoading: _newState.isLoading,
          complete: _newState.complete,
          isFailed: _newState.isFailed,
        );
        break;
      case SwitchCardEvent:
        await endPosition();
        yield const HomeState().copyWith(
          questions: _newState.questions,
          isLoading: _newState.isLoading,
          complete: _newState.complete,
          isFailed: _newState.isFailed,
        );
    }
  }

  Stream<HomeState>? _updateState(HomeState state) async* {
    if (state == _initialState) return;
    _initialState = state;
    yield state;
  }

  Future<void> _loadData() async {
    var questionWithUrlsList = <Question>[];
    var questionData = <Question>[];
    try {
      questionData = await FirebaseDataService().getQuestionsList();
    } on FirebaseException catch (e) {
      // handleError(e);
      _overlayMessage = e.message??'';
      notifyListeners();
    }
    final photoList = await _loadPhotos(questionData.length);
    questionWithUrlsList = questionData
        .map(
          (question) => question.copyWith(
            url: photoList.isNotEmpty ? photoList.removeLast() : null,
          ),
        )
        .toList()
      ..shuffle();
    _newState = HomeState.data(questionWithUrlsList.reversed.toList());
  }

  Future<List<String>> _loadPhotos(int length) async {
    final photos = <String>[];
    final getPhoto = UnsplashImageProvider().getPhoto;
    await safe(() async {
      final jsonList = await getPhoto(length);
      for (final unsplashPhoto in jsonList) {
        // ignore: non_constant_identifier_names
        photos.add(unsplashPhoto.urls!.small!);
      }
    });
    return photos;
  }

  void add(HomeEvent event) {
    _streamController.add(event);
  }

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _screenSize = MediaQuery.of(context).size;
    _position += details.delta;
    final x = _position.dx;
    if (x > 0) {
      _isGoingTrue = true;
    } else {
      _isGoingTrue = false;
    }
    _angle = 45 * x / _screenSize.width;
    notifyListeners();
  }

  Future<void> endPosition() async {
    _isDragging = false;
    notifyListeners();
    final answer = _getAnswer();
    if (answer == null) {
      _resetPosition();
      return;
    }
    await _swiped(answer);
  }

  bool? _getAnswer() {
    final x = _position.dx;
    final y = _position.dy;
    const delta = 100;

    if (x >= delta || y <= -delta) return true;
    if (x <= -delta || y >= delta) return false;
    return null;
  }

  Future<void> _swiped(bool isRight) async {
    if (isRight) {
      _angle = 20;
      _position += Offset(_screenSize.width * 2, 0);
    } else {
      _angle = -20;
      _position -= Offset(_screenSize.width * 2, 0);
    }
    if (isRight == _newState.questions?.last.answer) {
      await _nextCard();
    } else {
      await Navigator.pushReplacementNamed(context, Routes.loosingScreen);
    }
  }

  Future<void> _nextCard() async {
    if (_initialState.questions == null || _initialState.questions!.isEmpty) {
      _newState = HomeState.complete();
    }
    await Future<Duration?>.delayed(
      const Duration(milliseconds: 200),
    );
    _newState = HomeState.data(
      [..._initialState.questions!]..removeLast(),
    );
    notifyListeners();
    _resetPosition();
  }

  void _resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    _isGoingTrue = null;
    notifyListeners();
  }

  void resetImages() {
    _streamController.add(InitializeEvent());
    notifyListeners();
  }

  Future<void> logOut() async {
    final navigator = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    unawaited(navigator.pushReplacementNamed(Routes.introScreen));
  }
}
