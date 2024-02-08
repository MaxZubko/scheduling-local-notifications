import 'package:hive/hive.dart';

import '../models.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0, defaultValue: [])
  final List<NotifyModel> notifyList;

  UserModel({
    required this.notifyList,
  });
}
