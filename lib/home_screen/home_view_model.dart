import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/DataProvider.dart';
import 'package:flutter_app/core/view_model.dart';
import 'package:flutter_app/loosing_screen.dart';

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

  HomeViewModel(this._context) : super(_context);

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
    final questionList = <Question>[];
    const List<dynamic> jsonData = DataProvider.jsonQuestionsData;
    final photoList = _loadPhotos(jsonData.length);
    for (var i = 0; i < jsonData.length; i++) {
      final questionData = jsonData[i] as Map<String, dynamic>;
      final question = Question(
        question: questionData['question_text'] as String,
        answer: questionData['question_answer'] as bool,
        url: photoList.isNotEmpty ? photoList[i] : null,
      );
      questionList.add(question);
    }
    questionList.shuffle();
    _newState = HomeState.data(questionList.reversed.toList());
  }

  List<String> _loadPhotos(int length) {
    final photos = <String>[];
    safe(() async {
      final dynamic json = (await DataProvider.getPhoto(length)).data;
      final jsonList = json as List<dynamic>;
      for (final jsonMap in jsonList) {
        // ignore: non_constant_identifier_names
        photos.add(
          ((jsonMap as Map<String, dynamic>)['urls']
                  as Map<String, dynamic>)['full']
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
    // if()
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
    const delta = 100;

    if (x >= delta) return true;
    if (x <= -delta) return false;
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
      await Navigator.push<LoosingScreen>(
        _context,
        MaterialPageRoute(
          builder: (_) => const LoosingScreen(),
        ),
      );
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
    _loadData();
    notifyListeners();
  }
}
