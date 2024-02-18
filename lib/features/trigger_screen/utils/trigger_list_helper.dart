import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class TriggerListHelper {
  String getHierarchyIconPath(
      {required int index, required int lastIndex, bool isLongTitle = false}) {
    if (index == lastIndex) {
      return constants.Assets.hierarchyEndIcon;
    } else {
      return isLongTitle
          ? constants.Assets.hierarchyLongIcon
          : constants.Assets.hierarchyIcon;
    }
  }
}
