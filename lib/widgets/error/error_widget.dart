import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class ErrorsWidget extends StatelessWidget {
  final String error;
  final bool isError;
  const ErrorsWidget({super.key, required this.isError, required this.error});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isError,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Container(
          height: 48,
          color: constants.Colors.greyLight2,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              SvgPicture.asset(
                constants.Assets.errorIcon,
                color: constants.Colors.red,
              ),
              const SizedBox(width: 6),
              Text(
                error,
                style: constants.Styles.robotoRedS14W500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
