import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduling_local_notifications_app/state/state.dart';
import 'package:scheduling_local_notifications_app/widgets/widgets.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

import '../main_screen.dart';

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SwitchProvider>(
      builder: (context, switchProvider, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: switchProvider.isOnTimeSelected ? 16 : 0),
            child: Column(
              children: [
                if (switchProvider.isOnTimeSelected) ...[
                  const OneTimeNotifyList(),
                  DefaultButton(
                    title: 'Add new notification',
                    onPressed: () {},
                    iconPath: constants.Assets.addIcon,
                  ),
                  const SizedBox(height: 34),
                ] else ...[
                  const RecurringNotifyWidget(),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
