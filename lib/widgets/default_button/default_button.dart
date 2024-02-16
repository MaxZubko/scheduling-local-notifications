import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class DefaultButton extends StatefulWidget {
  final String title;
  final bool isDisableBtn;
  final Function() onPressed;
  final String? iconPath;
  final double height;
  final double borderRadius;
  const DefaultButton({
    super.key,
    this.isDisableBtn = false,
    required this.title,
    required this.onPressed,
    this.iconPath,
    this.height = 56,
    this.borderRadius = 8,
  });

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  late Color buttonColor;

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
        height: widget.height,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.iconPath != null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SvgPicture.asset(
                  widget.iconPath!,
                  color: constants.Colors.white,
                ),
              ),
            Text(
              widget.title,
              style: constants.Styles.robotoBoldWhiteS16W700,
            ),
          ],
        ),
      ),
    );
  }
}
