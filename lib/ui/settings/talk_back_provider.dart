import 'package:flutter/material.dart';

class TalkBackProvider with ChangeNotifier {
  bool _isTalkBackEnabled = false;

  bool get isTalkBackEnabled => _isTalkBackEnabled;

  void toggleTalkBack(bool value) {
    _isTalkBackEnabled = value;
    notifyListeners();
  }
}
