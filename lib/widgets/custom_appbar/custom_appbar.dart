import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isShowBackButton;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.isShowBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 78.0,
      titleSpacing: 0,
      title: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            if (isShowBackButton)
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    constants.Assets.backBtnLeft,
                    color: constants.Colors.white,
                    width: 11,
                    height: 19,
                  ),
                ),
              ),
            const Expanded(child: SizedBox()),
            Text(
              title,
              style: constants.Styles.robotoWhiteS16W700,
            ),
            isShowBackButton ? const SizedBox(width: 50) : const SizedBox(),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
