import 'package:hive/hive.dart';
import 'package:scheduling_local_notifications_app/enums/notify_background_enums/notify_background_enums.dart';

part 'notify_model.g.dart';

@HiveType(typeId: 1)
class NotifyModel extends HiveObject {
  @HiveField(0, defaultValue: '')
  final String time;

  @HiveField(1, defaultValue: '')
  final String message;

  @HiveField(2, defaultValue: '')
  final String iconPath;

  @HiveField(3, defaultValue: false)
  final bool isOneTime;

  @HiveField(4, defaultValue: NotifyBackgroundColors.grey)
  final NotifyBackgroundColors notifyBackgroundColors;

  @HiveField(5, defaultValue: 0)
  final int timestamp;

  @HiveField(6, defaultValue: 1)
  final int? recurring;

  NotifyModel({
    required this.time,
    required this.message,
    required this.iconPath,
    required this.isOneTime,
    required this.notifyBackgroundColors,
    required this.timestamp,
    required this.recurring,
  });
}
