class RecurringNotifyHelper {
  String getTitle(int recurring) {
    if (recurring > 1) {
      return '$recurring Minutes';
    } else {
      return '$recurring Minute';
    }
  }
}
