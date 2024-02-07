import 'package:flutter/material.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class CardButton extends StatefulWidget {
  final String title;
  final Function() onPressed;
  final bool isDisableBtn;
  const CardButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isDisableBtn = false,
  });

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  late Color buttonColor;

  @override
  void initState() {
    super.initState();
    buttonColor =
        widget.isDisableBtn ? constants.Colors.grey : constants.Colors.purple;
  }

  @override
  void didUpdateWidget(CardButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isDisableBtn != oldWidget.isDisableBtn) {
      buttonColor =
          widget.isDisableBtn ? constants.Colors.grey : constants.Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isDisableBtn) {
          setState(() {
            buttonColor = constants.Colors.purplePressed;
          });
          Future.delayed(const Duration(milliseconds: 50), () {
            setState(() {
              buttonColor = constants.Colors.purple;
            });
          });
        }
      },
      onTapDown: (_) {
        if (!widget.isDisableBtn) {
          setState(() {
            buttonColor = constants.Colors.purplePressed;
          });
        }
      },
      onTapUp: (_) {
        if (!widget.isDisableBtn) {
          widget.onPressed();
          setState(() {
            buttonColor = constants.Colors.purple;
          });
        }
      },
      child: Container(
        // width: 158,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: buttonColor,
          ),
        ),
        alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          widget.title,
          style:
              constants.Styles.robotoPurpleS14W700.copyWith(color: buttonColor),
        ),
      ),
    );
  }
}
