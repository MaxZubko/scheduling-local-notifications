import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class CustomCheckboxWidget extends StatefulWidget {
  const CustomCheckboxWidget({super.key});

  @override
  State<CustomCheckboxWidget> createState() => _CustomCheckboxWidgetState();
}

class _CustomCheckboxWidgetState extends State<CustomCheckboxWidget> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      child: Container(
        height: 23,
        width: 23,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              _isChecked ? constants.Colors.purple : constants.Colors.greyLight,
        ),
        alignment: Alignment.center,
        child: _isChecked
            ? SvgPicture.asset(
                constants.Assets.checkIcon,
              )
            : null,
      ),
    );
  }
}
