import 'package:flutter/material.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';

class EditNotificationProvider extends ChangeNotifier {
  String _notifyMessage = '';
  String _notifyTime = '';
  int _notifyTimestamp = 0;
  NotifyBackgroundColors _notifyBackColor = NotifyBackgroundColors.none;
  String _notifyIconPath = NotifyIconsEnums.none.path;
  bool _isOneTime = false;
  int? _recurring;
  List<int> _idList = [];

  String get notifyMessage => _notifyMessage;
  String get notifyTime => _notifyTime;
  int get notifyTimestamp => _notifyTimestamp;
  NotifyBackgroundColors get notifyBackColor => _notifyBackColor;
  String get notifyIconPath => _notifyIconPath;
  bool get isOneTime => _isOneTime;
  int? get recurring => _recurring;
  List<int> get idList => _idList;

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

  void addNotifyInfo(NotifyModel notify) {
    _notifyMessage = notify.message;
    _notifyTime = notify.time;
    _notifyTimestamp = notify.timestamp;
    _notifyBackColor = notify.notifyBackgroundColors;
    _notifyIconPath = notify.iconPath;
    _isOneTime = notify.isOneTime;
    _recurring = notify.recurring;
    _idList = notify.idList;
    notifyListeners();
  }
}
