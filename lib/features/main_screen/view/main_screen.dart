import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scheduling_local_notifications_app/features/main_screen/view/main_screen_body.dart';
import 'package:scheduling_local_notifications_app/widgets/widgets.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
        isShowBackButton: false,
        isExpandedAppBar: true,
      ),
      body: MainScreenBody(),
    );
  }
}
