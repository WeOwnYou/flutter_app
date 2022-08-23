import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/handlers/error_handler.dart';
import 'package:flutter_app/core/navigation/main_navigation.dart';
import 'package:flutter_app/core/ui/view_model.dart';
import 'package:flutter_app/domain/dio_network/dio_network_client.dart';

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

@immutable
class HomeState {
  final List<Question>? questions;
  final bool isLoading;
  final bool complete;
  final bool isFailed;

  const HomeState({
    this.questions,
    this.isLoading = false,
    this.complete = false,
    this.isFailed = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          questions == other.questions &&
          isLoading == other.isLoading &&
          complete == other.complete &&
          isFailed == other.isFailed;

  @override
  int get hashCode =>
      questions.hashCode ^
      isLoading.hashCode ^
      complete.hashCode ^
      isFailed.hashCode;

  HomeState copyWith({
    List<Question>? questions,
    bool? isLoading,
    bool? complete,
    bool? isFailed,
  }) {
    return HomeState(
      questions: questions ?? this.questions,
      isLoading: isLoading ?? this.isLoading,
      complete: complete ?? this.complete,
      isFailed: isFailed ?? this.isFailed,
    );
  }

  factory HomeState.loading() => const HomeState(
        questions: [],
        isLoading: true,
      );

  factory HomeState.data(List<Question> data) => HomeState(
        questions: data,
      );

  factory HomeState.complete() => const HomeState(
        questions: [],
        complete: true,
      );

  factory HomeState.failed() => const HomeState(
        questions: [],
        isFailed: true,
      );
}

abstract class HomeEvent {}

class InitializeEvent extends HomeEvent {}

class SwitchCardEvent extends HomeEvent {
  SwitchCardEvent();
}

class HomeViewModel extends ViewModel {
  SimpleErrorHandler errorHandler;
  final BuildContext _context;
  bool _isDragging = false;
  late Size _screenSize;
  double _angle = 0;
  Offset _position = Offset.zero;
  bool? _isGoingTrue;
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

  HomeViewModel(this._context, this.errorHandler) : super(errorHandler: errorHandler);

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
    var questionList = <Question>[];
    var jsonData = <Map<String, dynamic>>[];
    final snapshot = await FirebaseFirestore.instance
        .collection('/quiz_questions')
        .doc('HnPA3a7NcN2ymCvWCOzW')
        .get();
    if (!snapshot.exists || snapshot.data() == null) {
      handleError('Snapshot doesnt exist');
    } else {
      jsonData = ((snapshot.data() as Map<String, dynamic>)['questions']
              as List<dynamic>)
          .cast<Map<String, dynamic>>();
      final photoList = await _loadPhotos(jsonData.length);
      questionList = jsonData
          .map(_mapToQuestion)
          .map(
            (e) => e.copyWith(
              url: photoList.isNotEmpty ? photoList.removeLast() : null,
            ),
          )
          .toList()
        ..shuffle();
    }
    _newState = HomeState.data(questionList.reversed.toList());
  }

  Question _mapToQuestion(
    Map<String, dynamic> jsonQuestion,
  ) {
    return Question(
      answer: jsonQuestion['question_answer'] as bool,
      question: jsonQuestion['question_text'] as String,
    );
  }

  Future<List<String>> _loadPhotos(int length) async {
    final photos = <String>[];
    final getPhoto = DioNetwork().getPhoto;
    await safe(() async {
      final dynamic json = (await getPhoto(length)).data;
      final jsonList = json as List<dynamic>;
      for (final jsonMap in jsonList) {
        // ignore: non_constant_identifier_names
        photos.add(
          ((jsonMap as Map<String, dynamic>)['urls']
                  as Map<String, dynamic>)['small']
              .toString(),
        );
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
    _screenSize = MediaQuery.of(_context).size;
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
      await Navigator.pushReplacementNamed(_context, Routes.loosingScreen);
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

  void logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(_context, Routes.introScreen);
  }
}
