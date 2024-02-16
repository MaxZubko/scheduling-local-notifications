import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scheduling_local_notifications_app/widgets/widgets.dart';

import 'auth_screen_body.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Log In',
        isShowBackButton: false,
      ),
      body: AuthScreenBody(),
    );
  }
}
