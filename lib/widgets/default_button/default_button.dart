import 'package:flutter/material.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class DefaultButton extends StatefulWidget {
  final String title;
  final bool isDisableBtn;
  final Function() onPressed;
  const DefaultButton({
    super.key,
    this.isDisableBtn = false,
    required this.title,
    required this.onPressed,
  });

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  late Color buttonColor;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    buttonColor =
        widget.isDisableBtn ? constants.Colors.grey : constants.Colors.purple;
  }

  @override
  void didUpdateWidget(DefaultButton oldWidget) {
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
        setState(() {
          isPressed = true;
          buttonColor = constants.Colors.purplePressed;
        });
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            isPressed = false;
            buttonColor = constants.Colors.purple;
          });
        });
      },
      onTapDown: (_) {
        setState(() {
          isPressed = true;
          buttonColor = constants.Colors.purplePressed;
        });
      },
      onTapUp: (_) {
        widget.onPressed();
        setState(() {
          isPressed = false;
          buttonColor = constants.Colors.purple;
        });
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: constants.Styles.robotoWhiteS16W700,
          ),
        ),
      ),
    );
  }
}
