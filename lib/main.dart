import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduling_local_notifications_app/services/database/src/database_methods.dart';

import 'app.dart';
import 'services/database/database.dart';
import 'state/state.dart';

import 'package:get_it/get_it.dart';

void main() async {
  // init database
  await Database.initDatabase();

  GetIt.I.registerLazySingleton<DatabaseMethods>(() => DatabaseMethods());

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
