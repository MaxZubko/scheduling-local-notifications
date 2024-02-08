import 'package:flutter/material.dart';

import '../../enums/enums.dart';

class NewNotificationProvider extends ChangeNotifier {
  String _notifyMessage = '';
  String _notifyTime = '';
  int _notifyTimestamp = 0;
  NotifyBackgroundColors _notifyBackColor = NotifyBackgroundColors.none;
  String _notifyIconPath = NotifyIconsEnums.none.path;

  String get notifyMessage => _notifyMessage;
  String get notifyTime => _notifyTime;
  int get notifyTimestamp => _notifyTimestamp;
  NotifyBackgroundColors get notifyBackColor => _notifyBackColor;
  String get notifyIconPath => _notifyIconPath;

  void setNotifyMessage(String message) {
    _notifyMessage = message;
    notifyListeners();
  }

  void setNotifyTime({required String time, required int timestamp}) {
    _notifyTime = time;
    _notifyTimestamp = timestamp;
    notifyListeners();
  }

  void setNotifyBackColor(NotifyBackgroundColors color) {
    _notifyBackColor = color;
    notifyListeners();
  }

  void setNotifyIcon(String iconPath) {
    _notifyIconPath = iconPath;
    notifyListeners();
  }
}
