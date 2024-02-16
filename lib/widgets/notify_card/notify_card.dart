import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/router/router.dart';

import '../../models/models.dart';
import '../../services/services.dart';
import '../widgets.dart';

class NotifyCardWidget extends StatelessWidget {
  final List<NotifyModel> notifyList;
  final NotifyModel notify;
  final Color iconBackground;
  final bool isIconPath;
  const NotifyCardWidget({
    super.key,
    required this.iconBackground,
    required this.isIconPath,
    required this.notify,
    required this.notifyList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: constants.Colors.greyLight3,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: constants.Colors.purple,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 10, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isIconPath
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isIconPath)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: iconBackground,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: constants.Colors.greyDark,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          height: 18,
                          width: 18,
                          color: iconBackground,
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            notify.iconPath,
                          ),
                        ),
                      ),
                    ),
                  _notifyInfo(
                    text1: 'Time:',
                    text2: notify.time,
                    context: context,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  final DatabaseMethods database = GetIt.I<DatabaseMethods>();

                  database
                      .removeNotification(
                    idToRemoveList: notify.idList,
                  )
                      .then(
                    (value) {
                      GetIt.I<LocalNotificationService>()
                          .cancelNotification(notify.idList);
                    },
                  );
                },
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    constants.Assets.removeIcon,
                    color: constants.Colors.red,
                  ),
                ),
              ),
            ],
          ),
          isIconPath ? const SizedBox(height: 16) : const SizedBox(height: 7),
          _notifyInfo(
            text1: 'Message:',
            text2: notify.message,
            context: context,
          ),
          const SizedBox(height: 20),
          _cardButton(context),
        ],
      ),
    );
  }

  Widget _notifyInfo({
    required String text1,
    required String text2,
    required BuildContext context,
  }) {
    return IntrinsicWidth(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: constants.Styles.robotoRegularGreyDarkS14W400,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text2,
              style: constants.Styles.robotoDarkS14W700,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardButton(BuildContext context) {
    const String firstBtnTitle = 'Select triger 1';
    const String secondBtnTitle = 'Select triger 2';

    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CardButton(
              title: firstBtnTitle,
              onPressed: () {
                navigationOnTriggerScreen(
                  context: context,
                  title: firstBtnTitle,
                  trigger: 1,
                );
              },
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: CardButton(
              title: secondBtnTitle,
              onPressed: () {
                navigationOnTriggerScreen(
                  context: context,
                  title: secondBtnTitle,
                  trigger: 2,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void navigationOnTriggerScreen({
    required BuildContext context,
    required String title,
    required int trigger,
  }) {
    context.pushRoute(
      TriggerRoute(
        title: title,
        trigger: trigger,
      ),
    );
  }
}
