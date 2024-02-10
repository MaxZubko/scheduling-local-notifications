import '../../../models/models.dart';

class OneTimeNotifyListListener {
  List<NotifyModel> items = [];

  NotifyModel? getNearestItem(List<NotifyModel> list) {
    if (list.length == 1) {
      return list.first;
    } else if (list.isNotEmpty) {
      list.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return list.first;
    }
    return null;
  }

  bool checkItemExpiry({required DateTime now, required int timestamp}) {
    DateTime itemDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    if (itemDateTime.isBefore(now)) {
      return true;
    }
    return false;
  }
}
