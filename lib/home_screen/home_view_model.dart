import 'package:flutter/material.dart';
import 'package:flutter_app/DataProvider.dart';
import 'package:flutter_app/loosing_screen.dart';

class Question {
  String urlPhoto;
  String question;
  bool answer;
  Question(
      {required this.answer, required this.urlPhoto, required this.question});
}

class HomeViewModel extends ChangeNotifier {
  final BuildContext _context;
  bool _isDragging = false;
  late Size _screenSize;
  double _angle = 0;
  Offset _position = Offset.zero;
  bool? _isGoingTrue;
  final List<Question> _questions = [];

  bool? get isGoingTrue => _isGoingTrue;
  Offset get position => _position;
  double get angle => _angle;
  bool get isDragging => _isDragging;
  List<Question> get questions => _questions;

  HomeViewModel(this._context) {
    _loadData();
  }

  _loadData() async {
    for (Map<String, dynamic> questionData in DataProvider.jsonQuestionsData) {
      Question question = Question(
          question: questionData['question_text'],
          answer: questionData['question_answer'],
          // urlPhoto:
          //     'https://miro.medium.com/max/1200/1*ul46xGjg18pYRL9BufPn_w.png');
          urlPhoto:
              (await DataProvider.getPhoto()).data['urls']['full'] as String);
      _questions.add(question);
    }
  }

  startPosition(DragStartDetails details) {
    _isDragging = true;
    notifyListeners();
  }

  updatePosition(DragUpdateDetails details) {
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

  endPosition() {
    _isDragging = false;
    notifyListeners();

    final answer = _getAnswer();
    if (answer == null) {
      _resetPosition();
      return;
    }
    _swiped(answer);
  }

  bool? _getAnswer() {
    final x = _position.dx;
    const delta = 100;

    if (x >= delta) return true;
    if (x <= -delta) return false;
    return null;
  }

  _swiped(bool isRight) {
    if (isRight) {
      _angle = 20;
      _position += Offset(_screenSize.width * 2, 0);
    } else {
      _angle = -20;
      _position -= Offset(_screenSize.width * 2, 0);
    }
    if (isRight == questions.last.answer) {
      _nextCard();
    } else {
      Navigator.push(
          _context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoosingScreen()));
    }
  }

  _nextCard() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _questions.removeLast();
    _resetPosition();
  }

  _resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    _isGoingTrue = null;
    notifyListeners();
  }

  resetImages() {
    _loadData();
    notifyListeners();
  }
}
