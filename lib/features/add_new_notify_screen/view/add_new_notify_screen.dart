import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/state.dart';
import '../../../widgets/widgets.dart';
import 'add_new_notify_screen_body.dart';

@RoutePage()
class AddNewNotifyScreen extends StatelessWidget {
  final int? recurring;
  const AddNewNotifyScreen({
    super.key,
    this.recurring,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewNotificationProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Add new notification',
          isShowBackButton: true,
        ),
        body: AddNewNotifyScreenBody(
          recurring: recurring,
        ),
      ),
    );
  }
}
