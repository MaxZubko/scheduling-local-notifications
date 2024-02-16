import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/widgets/widgets.dart';

import '../../../enums/enums.dart';

class IconModalView extends StatefulWidget {
  final NotifyBackgroundColors selectedColor;
  final String selectedIconPath;
  final Function(NotifyBackgroundColors) onColorSelected;
  final Function(String) onIconSelected;
  const IconModalView({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
    required this.selectedIconPath,
    required this.onIconSelected,
  });

  @override
  State<IconModalView> createState() => _IconModalViewState();
}

class _IconModalViewState extends State<IconModalView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 34),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: constants.Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _headerModal(),
          const SizedBox(height: 16),
          _divider,
          const SizedBox(height: 20),
          BackGroundColorsList(
            selectedColor: widget.selectedColor,
            onColorSelected: widget.onColorSelected,
          ),
          const SizedBox(height: 16),
          NotifyIconsList(
            selectedIcon: widget.selectedIconPath,
            onColorSelected: widget.onIconSelected,
          ),
          const SizedBox(height: 78),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DefaultButton(
              title: 'Save changes',
              onPressed: () {
                AutoRouter.of(context).pop(true);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerModal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Icon style',
            style: constants.Styles.robotoBoldDarkS20W700,
          ),
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).pop(false);
            },
            child: SvgPicture.asset(
              constants.Assets.closeIcon,
              color: constants.Colors.purple,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _divider {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 1,
        color: constants.Colors.greyLight2,
      ),
    );
  }
}
