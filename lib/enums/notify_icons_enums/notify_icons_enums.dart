import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

enum NotifyIconsEnums {
  business,
  list,
  personCheck,
  notification,
  error,
  none,
}

extension NotifyIconsEnumsExtension on NotifyIconsEnums {
  String get path {
    switch (this) {
      case NotifyIconsEnums.business:
        return constants.Assets.businessIcon;
      case NotifyIconsEnums.list:
        return constants.Assets.listIcon;
      case NotifyIconsEnums.personCheck:
        return constants.Assets.personCheckIcon;
      case NotifyIconsEnums.notification:
        return constants.Assets.notificationIcon;
      case NotifyIconsEnums.error:
        return constants.Assets.errorPurpleIcon;
      default:
        return constants.Assets.imageIcon;
    }
  }
}
