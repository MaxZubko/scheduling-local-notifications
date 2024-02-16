import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/features/main_screen/main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isShowBackButton;
  final bool isExpandedAppBar;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.isShowBackButton,
    this.isExpandedAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: constants.Colors.mainDark,
        boxShadow: [
          BoxShadow(
            color: constants.Colors.mainDark.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 0.5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: statusBarHeight + 15),
            child: Row(
              children: [
                CupertinoButton(
                  onPressed: () => context.popRoute(),
                  child: SizedBox(
                    child: SvgPicture.asset(
                      constants.Assets.arrowLeft,
                      color: isShowBackButton
                          ? constants.Colors.white
                          : Colors.transparent,
                      width: 11,
                      height: 19,
                    ),
                  ),
                ),
                const Expanded(
                    child: SizedBox(
                  height: 30,
                )),
                Text(
                  title,
                  style: constants.Styles.robotoBoldWhiteS16W700,
                ),
                const SizedBox(width: 40),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          if (isExpandedAppBar)
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: SwitchNotificationList(),
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        isExpandedAppBar ? (kToolbarHeight + 80) : kToolbarHeight + 15,
      );
}
