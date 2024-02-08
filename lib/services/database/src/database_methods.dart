import '../../../models/models.dart';
import 'boxes.dart';

class DatabaseMethods {
  Future<UserModel> getUser() async {
    final user = Boxes.getUser();
    final UserModel getUser;

    if (user.isEmpty) {
      getUser = UserModel(notifyList: []);
      await user.add(getUser);
    } else {
      getUser = user.getAt(0)!;
    }

    return getUser;
  }

  Future<void> addOneTimeNotification(NotifyModel notify) async {
    final UserModel user = Boxes.getUser().getAt(0)!;

    user.notifyList.add(notify);

    await user.save();
  }

  Future<void> removeNotification({
    required int timestamp,
    bool isRecurring = false,
  }) async {
    final UserModel user = Boxes.getUser().getAt(0)!;
    final List<NotifyModel> list = user.notifyList;

    list.removeWhere((element) => element.timestamp == timestamp);

    await user.save();
  }
}
