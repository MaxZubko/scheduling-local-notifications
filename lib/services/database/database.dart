import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

class Database {
  static const String notifyKey = 'notifications';

  static Future<void> initDatabase() async {
    try {
      await Hive.initFlutter();
    } catch (error) {
      log(error.toString());
    }
  }
}
