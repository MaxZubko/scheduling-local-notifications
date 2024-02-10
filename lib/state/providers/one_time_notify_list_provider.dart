import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/models.dart';

class OneTimeNotifyListProvider extends ChangeNotifier {
  List<NotifyModel> items = [];
  int? _deletedElementId;

  int? get deletedElementId => _deletedElementId;

  late Stream<DateTime> _timerStream;
  late NotifyModel _currentItem;

  OneTimeNotifyListProvider(this.items) {
    _timerStream =
        Stream<DateTime>.periodic(const Duration(seconds: 1), (count) {
      return DateTime.now();
    });

    _currentItem = _getNearestItem();
    _timerStream.listen((currentTime) {
      _checkItemExpiry(currentTime);
    });
  }

  NotifyModel _getNearestItem() {
    items.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return items.first;
  }

  void _checkItemExpiry(DateTime currentTime) {
    DateTime itemDateTime =
        DateTime.fromMillisecondsSinceEpoch(_currentItem.timestamp);
    if (itemDateTime.isBefore(currentTime)) {
      _deletedElementId = _currentItem.idList.first;
      if (items.isNotEmpty) {
        _currentItem = _getNearestItem();
      }
      notifyListeners();
    }
  }

  void idCancellation() {
    _deletedElementId = null;

    notifyListeners();
  }
}
