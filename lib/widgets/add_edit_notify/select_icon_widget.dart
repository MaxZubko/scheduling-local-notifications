import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/widgets/widgets.dart';

import '../../../enums/enums.dart';

class SelectIconWidget extends StatefulWidget {
  final NotifyBackgroundColors selectedNotifyBackColor;
  final String selectedNotifyIcon;
  final Function(NotifyBackgroundColors) onNotifyBackColorSelected;
  final Function(String) onNotifyIconSelected;
  final Function() onSavedIcon;
  const SelectIconWidget({
    super.key,
    required this.selectedNotifyBackColor,
    required this.onNotifyBackColorSelected,
    required this.onNotifyIconSelected,
    required this.selectedNotifyIcon,
    required this.onSavedIcon,
  });

  @override
  State<SelectIconWidget> createState() => _SelectIconWidgetState();
}

class _SelectIconWidgetState extends State<SelectIconWidget> {
  NotifyBackgroundColors _selectedColor = NotifyBackgroundColors.grey;
  String _selectedIcon = NotifyIconsEnums.business.path;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.selectedNotifyBackColor;
    _selectedIcon = widget.selectedNotifyIcon;
  }

  @override
  void didUpdateWidget(SelectIconWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedNotifyBackColor != oldWidget.selectedNotifyBackColor) {
      _selectedColor = widget.selectedNotifyBackColor;
    }
    if (widget.selectedNotifyIcon != oldWidget.selectedNotifyIcon) {
      _selectedIcon = widget.selectedNotifyIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Icon',
          style: constants.Styles.robotoDarkS14W500,
        ),
        const SizedBox(height: 6),
        _selectIconWidget(
          context,
          _selectedColor,
          _selectedIcon,
        ),
      ],
    );
  }

  Widget _selectIconWidget(BuildContext context,
      NotifyBackgroundColors selectedColor, String selectedIconPath) {
    final String iconPath = selectedIconPath != NotifyIconsEnums.none.path
        ? selectedIconPath
        : constants.Assets.imageIcon;
    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: constants.Colors.grey),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(iconPath),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 158,
          child: CardButton(
            onPressed: () {
              iconModal(
                context,
                selectedColor,
                selectedIconPath,
              );
            },
            title: 'Select icon',
          ),
        ),
      ],
    );
  }

  void iconModal(BuildContext context, NotifyBackgroundColors selectedColor,
      String selectedIconPath) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
      ),
      context: context,
      builder: (context) {
        return IconModalView(
          selectedColor: selectedColor,
          selectedIconPath: selectedIconPath,
          onColorSelected: widget.onNotifyBackColorSelected,
          onIconSelected: widget.onNotifyIconSelected,
        );
      },
    ).then(
      (value) {
        if (value) {}
      },
    );
  }
}
