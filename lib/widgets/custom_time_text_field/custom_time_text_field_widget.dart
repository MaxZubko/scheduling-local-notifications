import 'package:flutter/material.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class CustomTimeTextFieldWidget extends StatelessWidget {
  final List<TextEditingController> controllersList;
  final List<FocusNode> focusNodesList;
  final ValueChanged<String> onChanged;

  const CustomTimeTextFieldWidget({
    Key? key,
    required this.controllersList,
    required this.focusNodesList,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          if (index % 2 == 0) {
            final textFieldIndex = index ~/ 2;

            return Container(
              width: 44,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: focusNodesList[textFieldIndex].hasFocus
                      ? constants.Colors.purple
                      : constants.Colors.greyLight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controllersList[textFieldIndex],
                maxLength: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                focusNode: focusNodesList[textFieldIndex],
                onChanged: (value) {
                  //TODO max value for hours and minutes

                  onChanged(value);
                  if (value.isNotEmpty) {
                    switchToNextTextField(
                      context: context,
                      currentIndex: textFieldIndex,
                    );
                  } else {
                    switchToPreviousTextField(
                      context: context,
                      currentIndex: textFieldIndex,
                    );
                  }
                },
                cursorColor: constants.Colors.purple,
                decoration: InputDecoration(
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: constants.Colors.purple,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: InputBorder.none,
                ),
              ),
            );
          } else if (index % 4 == 1) {
            return const SizedBox(width: 12);
          } else {
            return const Row(
              children: [
                SizedBox(width: 11),
                Text(
                  ':',
                  style: constants.Styles.robotoGreyS32W700,
                ),
                SizedBox(width: 11),
              ],
            );
          }
        },
      ),
    );
  }

  void switchToNextTextField(
      {required BuildContext context, required int currentIndex}) {
    if (currentIndex < controllersList.length - 1) {
      FocusScope.of(context).requestFocus(focusNodesList[currentIndex + 1]);
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  void switchToPreviousTextField(
      {required BuildContext context, required int currentIndex}) {
    if (currentIndex > 0) {
      FocusScope.of(context).requestFocus(focusNodesList[currentIndex - 1]);
    }
  }
}
