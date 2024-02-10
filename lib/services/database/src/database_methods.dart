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

  Future<void> addNotification(NotifyModel notify) async {
    try {
      final UserModel user = Boxes.getUser().getAt(0)!;

      user.notifyList.add(notify);

      await user.save();
    } catch (e) {
      return;
    }
  }

  Future<void> updateNotification(NotifyModel notify) async {
    try {
      final UserModel user = Boxes.getUser().getAt(0)!;
      final List<NotifyModel> list = user.notifyList;

      list.removeWhere(
          (element) => element.idList.any((id) => notify.idList.contains(id)));

      user.notifyList.add(notify);

      await user.save();
    } catch (e) {
      return;
    }
  }

  Future<void> removeNotification({
    required List<int> idToRemoveList,
    bool isRecurring = false,
  }) async {
    try {
      final UserModel user = Boxes.getUser().getAt(0)!;
      final List<NotifyModel> list = user.notifyList;

      list.removeWhere(
          (element) => element.idList.any((id) => idToRemoveList.contains(id)));

      await user.save();
    } catch (e) {
      return;
    }
  }
}
