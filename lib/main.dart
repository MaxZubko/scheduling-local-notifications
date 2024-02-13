import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'features/main_screen/utils/one_time_notify_list_listener.dart';
import 'features/trigger_screen/trigger.dart';
import 'features/utils/utils.dart';
import 'services/services.dart';
import 'state/state.dart';

import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init database
  await Database.initDatabase();

  GetIt.I.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());

  GetIt.I.registerLazySingleton<DatabaseMethods>(() => DatabaseMethods());

  GetIt.I.registerLazySingleton<NotifyIdHelper>(() => NotifyIdHelper());

  GetIt.I.registerLazySingleton<OneTimeNotifyListListener>(
      () => OneTimeNotifyListListener());

  GetIt.I.registerLazySingleton<TriggerListHelper>(() => TriggerListHelper());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => SwitchProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
