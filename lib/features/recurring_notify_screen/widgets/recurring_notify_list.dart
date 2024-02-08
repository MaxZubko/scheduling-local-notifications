import 'package:flutter/material.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/models/models.dart';

import '../../../enums/enums.dart';
import '../../../widgets/widgets.dart';

class RecurringNotifyList extends StatelessWidget {
  final List<NotifyModel> recurringNotifyList;
  const RecurringNotifyList({
    super.key,
    required this.recurringNotifyList,
  });

  @override
  Widget build(BuildContext context) {
    if (recurringNotifyList.isNotEmpty) {
      return _notifyCard();
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Add the first notification',
          style: constants.Styles.robotoGreyS16W400,
        ),
      );
    }
  }

  Widget _notifyCard() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recurringNotifyList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final NotifyModel notify = recurringNotifyList[index];
        final bool isIconPath = notify.iconPath != NotifyIconsEnums.none.path;
        final Color cardColor =
            notify.notifyBackgroundColors == NotifyBackgroundColors.none
                ? constants.Colors.greyLight3
                : notify.notifyBackgroundColors.color;

        return Padding(
          padding: EdgeInsets.only(
            top: 16,
            bottom: index == recurringNotifyList.length - 1 ? 24 : 0,
          ),
          child: NotifyCardWidget(
            notifyList: recurringNotifyList,
            notify: notify,
            cardColor: cardColor,
            isIconPath: isIconPath,
          ),
        );
      },
    );
  }
}
