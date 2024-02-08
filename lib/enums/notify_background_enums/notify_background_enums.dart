import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

part 'notify_background_enums.g.dart';

@HiveType(typeId: 2)
enum NotifyBackgroundColors {
  @HiveField(0)
  grey,
  @HiveField(1)
  orange,
  @HiveField(2)
  yellow,
  @HiveField(3)
  purple,
  @HiveField(4)
  pink,
  @HiveField(5)
  none,
}

extension NotifyBackgroundEnumsExtension on NotifyBackgroundColors {
  Color get color {
    switch (this) {
      case NotifyBackgroundColors.grey:
        return constants.Colors.greyBackground;
      case NotifyBackgroundColors.orange:
        return constants.Colors.orangeBackground;
      case NotifyBackgroundColors.yellow:
        return constants.Colors.yellowBackground;
      case NotifyBackgroundColors.purple:
        return constants.Colors.purpleBackground;
      case NotifyBackgroundColors.pink:
        return constants.Colors.pinkBackground;
      default:
        return constants.Colors.greyLight3;
    }
  }
}
