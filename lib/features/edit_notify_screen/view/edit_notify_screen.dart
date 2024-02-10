import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/models.dart';
import '../../../state/providers/edit_notification_provider.dart';
import '../../../widgets/widgets.dart';
import 'edit_notify_screen_body.dart';

@RoutePage()
class EditNotifyScreen extends StatelessWidget {
  final int? recurring;
  final NotifyModel notify;
  const EditNotifyScreen({
    super.key,
    this.recurring,
    required this.notify,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditNotificationProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Edit notification',
          isShowBackButton: true,
        ),
        body: EditNotifyScreenBody(
          recurring: recurring,
          notify: notify,
        ),
      ),
    );
  }
}
