import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'state/state.dart';

void main() async {
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
