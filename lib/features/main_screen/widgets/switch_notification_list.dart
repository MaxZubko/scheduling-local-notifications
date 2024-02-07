import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scheduling_local_notifications_app/state/state.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class SwitchNotificationList extends StatelessWidget {
  const SwitchNotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SwitchProvider>(
      builder: (context, switchProvider, _) {
        final bool isOnTimeSelected = switchProvider.isOnTimeSelected;

        return Container(
          height: 48,
          decoration: BoxDecoration(
            color: constants.Colors.greyLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      switchProvider.toggleList(true);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: isOnTimeSelected
                            ? constants.Colors.purple
                            : Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            constants.Assets.oneTime,
                            color: isOnTimeSelected
                                ? constants.Colors.white
                                : constants.Colors.mainDark,
                          ),
                          const SizedBox(width: 9),
                          Text(
                            'One-time',
                            style: isOnTimeSelected
                                ? constants.Styles.robotoWhiteS16W700
                                : constants.Styles.robotoWhiteS16W700.copyWith(
                                    color: constants.Colors.mainDark,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      switchProvider.toggleList(false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: !isOnTimeSelected
                            ? constants.Colors.purple
                            : Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            constants.Assets.recurring,
                            color: !isOnTimeSelected
                                ? constants.Colors.white
                                : constants.Colors.mainDark,
                          ),
                          const SizedBox(width: 9),
                          Text(
                            'Recurring',
                            style: !isOnTimeSelected
                                ? constants.Styles.robotoWhiteS16W700
                                : constants.Styles.robotoWhiteS16W700.copyWith(
                                    color: constants.Colors.mainDark,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
