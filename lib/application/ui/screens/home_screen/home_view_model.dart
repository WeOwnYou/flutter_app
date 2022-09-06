import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/navigation/router.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_events.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_state.dart';
import 'package:flutter_app/core/service/questions_service.dart';
import 'package:flutter_app/core/ui/handlers/error_handler.dart';
import 'package:flutter_app/core/ui/overlay/connectivity_overlay.dart';
import 'package:flutter_app/core/ui/view_model/view_model.dart';

class HomeViewModel extends ViewModel {
  final BuildContext context;

  /// animation
  bool _isDragging = false;
  late Size _screenSize;
  double _angle = 0;
  Offset _position = Offset.zero;
  bool? _isGoingTrue;

  /// endAnimation
  HomeState _initialState = HomeState.data(const <Question>[]);
  HomeState _newState = HomeState.data(const []);
  late final Stream<HomeState> _stream;
  final StreamController<HomeEvent> _streamController =
      StreamController<HomeEvent>.broadcast();
  // late final StreamSubscription<ConnectivityResult> _connectivitySubscription;

  /// animation getter
  bool? get isGoingTrue => _isGoingTrue;
  Offset get position => _position;
  double get angle => _angle;
  bool get isDragging => _isDragging;

  /// endAnimationGetter
  HomeState get initialState => _initialState;
  Stream<HomeState> get stream => _stream;

  HomeViewModel(this.context, ErrorHandler errorHandler)
      : super(errorHandler: errorHandler);

  @override
  Future<void> onInit() async {
    super.onInit();
    _stream = _streamController.stream
        .asyncExpand<HomeState>(_mapEventToState)
        .asyncExpand<HomeState>(_updateState)
        .asBroadcastStream();
    _stream.listen((event) {});
    _streamController.add(InitializeEvent());
    // await _checkConnectivity();
    if(ConnectivityOverlay.instance.overlayEntry != null){

    }

  }

  // Future<void> _checkConnectivity() async{
  //   await _onConnectivityChanged(await Connectivity().checkConnectivity());
  //   _connectivitySubscription =
  //       Connectivity().onConnectivityChanged.listen(_onConnectivityChanged);
  // }
  //
  // Future<void> _onConnectivityChanged(ConnectivityResult? e) async{
  //   if(e == ConnectivityResult.none) {
  //     print('net');
  //     ConnectivityOverlay.instance.showOverlay(context, 'No internet');
  //   }
  //   else{
  //     ConnectivityOverlay.instance.removeOverlay();
  //     _streamController.add(InitializeEvent());
  //   }
  // }

  /*
  @override
  void dispose() {
    super.dispose();
    // _connectivitySubscription.cancel();
    // _streamController.close();
  }

   */

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
    var questionData = <Question>[];
    safe(
      () async {},
      onError: () {
        // TODO(USEFUL): THINK ABOUT IT!!!!
      },
    );
    try {
      questionData = await QuestionsService().getQuestionsList();
    } on FirebaseException catch (e) {
      handleError(e);
      notifyListeners();
    }
    _newState = HomeState.data(questionData.reversed.toList());
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
      await context.router.replaceNamed(Routes.loosingScreen);
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

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await context.router.replaceNamed(Routes.introScreen);
  }
}
