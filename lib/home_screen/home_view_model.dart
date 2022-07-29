import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier{
  final BuildContext _context;
  bool _isDragging = false;
  // final Size _screenSize;
  // double _angle = 0;
  Offset _position = Offset.zero;
  Offset get position => _position;
  // double get angle => _angle;
  bool get isDragging => _isDragging;
  HomeViewModel(this._context) ;
      // : _screenSize = MediaQuery.of(_context).size;

  startPosition(DragStartDetails details){
    _isDragging = true;
    notifyListeners();
  }
  updatePosition(DragUpdateDetails details){
    _position += details.delta;
    final x = _position.dx;
    // _angle = 45 * x / _screenSize.width;
    notifyListeners();
  }

  endPosition(){
    resetPosition();
  }

  resetPosition(){
    _isDragging = false;
    _position = Offset.zero;
    // _angle = 0;
    notifyListeners();
  }
}