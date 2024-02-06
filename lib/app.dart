import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router/router.dart';
import 'state/state.dart';
import 'theme/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final appRouter = AppRouter(authProvider);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: mainTheme,
          routerConfig: appRouter.config(),
          title: 'Scheduling Local Notifications',
        );
      },
    );
  }
}
