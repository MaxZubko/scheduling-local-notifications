import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';
import 'triger_screen_body.dart';

@RoutePage()
class TriggerScreen extends StatelessWidget {
  final String title;
  final int trigger;
  const TriggerScreen({
    super.key,
    required this.title,
    required this.trigger,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        isShowBackButton: true,
      ),
      body: TriggerScreenBody(
        trigger: trigger,
      ),
    );
  }
}
