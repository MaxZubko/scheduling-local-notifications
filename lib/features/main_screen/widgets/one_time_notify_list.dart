import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/models/models.dart';
import 'package:scheduling_local_notifications_app/router/router.dart';

import '../../../enums/enums.dart';
import '../../../services/services.dart';
import '../../../widgets/widgets.dart';
import '../utils/one_time_notify_list_listener.dart';

class OneTimeNotifyList extends StatefulWidget {
  final List<NotifyModel> onTimeNotifyList;
  const OneTimeNotifyList({
    super.key,
    required this.onTimeNotifyList,
  });

  @override
  State<OneTimeNotifyList> createState() => _OneTimeNotifyListState();
}

class _OneTimeNotifyListState extends State<OneTimeNotifyList> {
  late Stream<DateTime> _timerStream;
  late StreamSubscription<DateTime> _timerSubscription;
  NotifyModel? nearestItem;

  List<NotifyModel> onTimeNotifyList = [];

  @override
  void initState() {
    onTimeNotifyList = widget.onTimeNotifyList;
    _timerStream = Stream<DateTime>.periodic(
      const Duration(seconds: 1),
      (count) => DateTime.now(),
    ).asBroadcastStream();
    _timerSubscription = _timerStream.listen((currentTime) {});

    nearestItem = _getNearestItem(onTimeNotifyList);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OneTimeNotifyList oldWidget) {
    if (onTimeNotifyList != widget.onTimeNotifyList) {
      onTimeNotifyList = widget.onTimeNotifyList;
      nearestItem = _getNearestItem(onTimeNotifyList);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _timerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTimeNotifyList.isNotEmpty) {
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
    onTimeNotifyList.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return StreamBuilder<DateTime>(
      stream: _timerStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final currentTime = snapshot.data!;
          if (nearestItem != null) {
            final bool isDeleteItem =
                GetIt.I<OneTimeNotifyListListener>().checkItemExpiry(
              now: currentTime,
              timestamp: nearestItem!.timestamp,
            );

            if (isDeleteItem) {
              final DatabaseMethods database = GetIt.I<DatabaseMethods>();

              database
                  .removeNotification(
                    idToRemoveList: nearestItem!.idList,
                  )
                  .then(
                    (value) => nearestItem = null,
                  );
            }
          } else {
            nearestItem = _getNearestItem(onTimeNotifyList);
          }
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: onTimeNotifyList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final NotifyModel notify = onTimeNotifyList[index];
            final bool isIconPath =
                notify.iconPath != NotifyIconsEnums.none.path;
            final Color cardColor =
                notify.notifyBackgroundColors == NotifyBackgroundColors.none
                    ? constants.Colors.greyLight3
                    : notify.notifyBackgroundColors.color;

            return Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: GestureDetector(
                onTap: () {
                  context.pushRoute(EditNotifyRoute(notify: notify));
                },
                child: NotifyCardWidget(
                  notifyList: onTimeNotifyList,
                  notify: notify,
                  cardColor: cardColor,
                  isIconPath: isIconPath,
                ),
              ),
            );
          },
        );
      },
    );
  }

  NotifyModel? _getNearestItem(List<NotifyModel> list) {
    return GetIt.I<OneTimeNotifyListListener>().getNearestItem(list);
  }
}
