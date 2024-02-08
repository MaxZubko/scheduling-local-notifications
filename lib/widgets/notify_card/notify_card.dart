import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

import '../../models/models.dart';
import '../../services/services.dart';
import '../widgets.dart';

class NotifyCardWidget extends StatelessWidget {
  final List<NotifyModel> notifyList;
  final NotifyModel notify;
  final Color cardColor;
  final bool isIconPath;
  const NotifyCardWidget({
    super.key,
    required this.cardColor,
    required this.isIconPath,
    required this.notify,
    required this.notifyList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: constants.Colors.purple,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 10, 16),
      child: Column(
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
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: constants.Colors.greyDark,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          height: 18,
                          width: 18,
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
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  final DatabaseMethods database = GetIt.I<DatabaseMethods>();

                  database.removeNotification(
                    timestamp: notify.timestamp,
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
          if (isIconPath) const SizedBox(height: 8),
          _notifyInfo(
            text1: 'Message:',
            text2: notify.message,
          ),
          const SizedBox(height: 16),
          _cardButton(),
        ],
      ),
    );
  }

  Widget _notifyInfo({
    required String text1,
    required String text2,
  }) {
    return Row(
      children: [
        Text(
          text1,
          style: constants.Styles.robotoGreyDarkS14W400,
        ),
        const SizedBox(width: 4),
        Text(
          text2,
          style: constants.Styles.robotoDarkS14W700,
        ),
      ],
    );
  }

  Widget _cardButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CardButton(
              title: 'Select triger 1',
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: CardButton(
              title: 'Select triger 2',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
