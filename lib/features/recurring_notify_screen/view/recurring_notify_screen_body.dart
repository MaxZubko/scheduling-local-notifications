import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/models.dart';
import '../../../router/router.dart';
import '../../../services/services.dart';
import '../../../widgets/widgets.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

import '../recurring_notify.dart';

class RecurringNotifyScreenBody extends StatefulWidget {
  final int recurring;
  const RecurringNotifyScreenBody({
    super.key,
    required this.recurring,
  });

  @override
  State<RecurringNotifyScreenBody> createState() =>
      _RecurringNotifyScreenBodyState();
}

class _RecurringNotifyScreenBodyState extends State<RecurringNotifyScreenBody> {
  late Box<UserModel> user;

  @override
  void initState() {
    super.initState();
    user = Boxes.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: ValueListenableBuilder<Box<UserModel>>(
          valueListenable: user.listenable(),
          builder: (context, box, state) {
            final UserModel? userModel = user.getAt(0);

            return Column(
              children: [
                RecurringNotifyList(
                  recurringNotifyList: getNotifyList(userModel),
                ),
                DefaultButton(
                  title: 'Add new notification',
                  onPressed: () {
                    context.pushRoute(AddNewNotifyRoute(
                      recurring: widget.recurring,
                    ));
                  },
                  iconPath: constants.Assets.addIcon,
                ),
                const SizedBox(height: 34),
              ],
            );
          },
        ),
      ),
    );
  }

  List<NotifyModel> getNotifyList(UserModel? userModel) {
    List<NotifyModel> list = [];
    if (userModel != null || userModel!.notifyList.isNotEmpty) {
      final List<NotifyModel> notifyList = userModel.notifyList;
      list.addAll(
        notifyList.where(
          (element) =>
              !element.isOneTime && element.recurring == widget.recurring,
        ),
      );
    }

    return list;
  }
}
