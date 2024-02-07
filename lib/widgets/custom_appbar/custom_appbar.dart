import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/features/main_screen/main_screen.dart';

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
      color: constants.Colors.mainDark,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: statusBarHeight + 15),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 30,
                    alignment: Alignment.center,
                    child: isShowBackButton
                        ? SvgPicture.asset(
                            constants.Assets.arrowLeft,
                            color: constants.Colors.white,
                            width: 11,
                            height: 19,
                          )
                        : null,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  title,
                  style: constants.Styles.robotoWhiteS16W700,
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
        isExpandedAppBar ? (kToolbarHeight + 70) : kToolbarHeight + 20,
      );
}
