import 'package:flutter/material.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/enums/notify_background_enums/notify_background_enums.dart';

class BackGroundColorsList extends StatefulWidget {
  final NotifyBackgroundColors selectedColor;
  final ValueChanged<NotifyBackgroundColors> onColorSelected;
  const BackGroundColorsList({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  State<BackGroundColorsList> createState() => _BackGroundColorsListState();
}

class _BackGroundColorsListState extends State<BackGroundColorsList> {
  List<NotifyBackgroundColors> values = NotifyBackgroundColors.values;
  late NotifyBackgroundColors _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Background colors',
          style: constants.Styles.robotoGreyDarkS16W500,
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
        itemCount: NotifyBackgroundColors.values.length - 1,
        itemBuilder: (context, index) {
          final color = NotifyBackgroundColors.values[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = color;
              });

              widget.onColorSelected(color);
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: color == _selectedColor
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
                  color: color.color,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
