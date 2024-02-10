import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scheduling_local_notifications_app/models/models.dart';
import 'package:scheduling_local_notifications_app/router/router.dart';
import 'package:scheduling_local_notifications_app/state/state.dart';
import 'package:scheduling_local_notifications_app/widgets/widgets.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

import '../../../services/services.dart';
import '../main.dart';

class MainScreenBody extends StatefulWidget {
  const MainScreenBody({super.key});

  @override
  State<MainScreenBody> createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  late Box<UserModel> user;

  @override
  void initState() {
    super.initState();
    user = Boxes.getUser();

    GetIt.I<LocalNotificationService>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SwitchProvider>(
      builder: (context, switchProvider, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: switchProvider.isOnTimeSelected ? 16 : 0),
            child: ValueListenableBuilder<Box<UserModel>>(
              valueListenable: user.listenable(),
              builder: (context, box, state) {
                final UserModel? userModel = user.getAt(0);

                return Column(
                  children: [
                    if (switchProvider.isOnTimeSelected) ...[
                      OneTimeNotifyList(
                        onTimeNotifyList: getNotifyList(userModel),
                      ),
                      DefaultButton(
                        title: 'Add new notification',
                        onPressed: () {
                          context.pushRoute(AddNewNotifyRoute());
                        },
                        iconPath: constants.Assets.addIcon,
                      ),
                      const SizedBox(height: 34),
                    ] else ...[
                      const RecurringNotifyWidget(),
                    ]
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  List<NotifyModel> getNotifyList(UserModel? userModel) {
    List<NotifyModel> list = [];
    if (userModel != null || userModel!.notifyList.isNotEmpty) {
      final List<NotifyModel> notifyList = userModel.notifyList;
      list.addAll(
        notifyList.where(
          (element) => element.isOneTime,
        ),
      );
    }

    return list;
  }
}
