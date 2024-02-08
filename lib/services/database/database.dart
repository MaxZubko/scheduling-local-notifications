import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

import '../../enums/enums.dart';
import '../../models/models.dart';

class Database {
  static const String user = 'user';

  static Future<void> initDatabase() async {
    try {
      await Hive.initFlutter();

      Hive.registerAdapter(UserModelAdapter());
      Hive.registerAdapter(NotifyModelAdapter());
      Hive.registerAdapter(NotifyBackgroundColorsAdapter());

      await Hive.openBox<UserModel>(user);
    } catch (error) {
      log(error.toString());
    }
  }
}
