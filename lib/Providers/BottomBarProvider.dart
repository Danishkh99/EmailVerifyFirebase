import 'package:flutter/cupertino.dart';

class BottomBarprovider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
