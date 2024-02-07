import 'package:hive/hive.dart';

part 'notify_model.g.dart';

@HiveType(typeId: 0)
class NotifyModel extends HiveObject {
  @HiveField(0, defaultValue: '')
  final String time;

  @HiveField(1, defaultValue: '')
  final String message;

  @HiveField(2, defaultValue: '')
  final String iconPath;

  @HiveField(3, defaultValue: false)
  final bool isOneTime;

  NotifyModel({
    required this.time,
    required this.message,
    required this.iconPath,
    required this.isOneTime,
  });
}
