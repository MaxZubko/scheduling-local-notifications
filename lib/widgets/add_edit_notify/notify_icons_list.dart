import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/enums/enums.dart';

class NotifyIconsList extends StatefulWidget {
  final String selectedIcon;
  final ValueChanged<String> onColorSelected;
  const NotifyIconsList({
    super.key,
    required this.selectedIcon,
    required this.onColorSelected,
  });

  @override
  State<NotifyIconsList> createState() => _NotifyIconsListState();
}

class _NotifyIconsListState extends State<NotifyIconsList> {
  late String _selectedIcon;

  @override
  void initState() {
    super.initState();
    _selectedIcon = widget.selectedIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.5),
          child: Text(
            'Select icons',
            style: constants.Styles.robotoGreyDarkS16W500,
          ),
        ),
        const SizedBox(height: 11),
        _backgroundList(),
      ],
    );
  }

  Widget _backgroundList() {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // I don't display the last element none
        itemCount: NotifyIconsEnums.values.length - 1,
        itemBuilder: (context, index) {
          final String icon = NotifyIconsEnums.values[index].path;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIcon = icon;
              });

              widget.onColorSelected(icon);
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: index == NotifyIconsEnums.values.length ? 0 : 4,
              ),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
                    color: _selectedIcon == icon
                        ? constants.Colors.purple
                        : Colors.transparent,
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: constants.Colors.greyLight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(icon),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
