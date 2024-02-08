import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';
import '../recurring_notify.dart';
import 'recurring_notify_screen_body.dart';

@RoutePage()
class RecurringNotifyScreen extends StatelessWidget {
  final int recurring;
  const RecurringNotifyScreen({super.key, required this.recurring});

  @override
  Widget build(BuildContext context) {
    final helper = RecurringNotifyHelper();

    return Scaffold(
      appBar: CustomAppBar(
        title: helper.getTitle(recurring),
        isShowBackButton: true,
      ),
      body: RecurringNotifyScreenBody(recurring: recurring),
    );
  }
}
