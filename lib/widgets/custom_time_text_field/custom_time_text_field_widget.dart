import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/enums/error_type_enums/error_type_enums.dart';
import 'package:scheduling_local_notifications_app/state/providers/error_provider.dart';

class CustomTimeTextFieldWidget extends StatefulWidget {
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
  State<CustomTimeTextFieldWidget> createState() =>
      _CustomTimeTextFieldWidgetState();
}

class _CustomTimeTextFieldWidgetState extends State<CustomTimeTextFieldWidget> {
  // so that focus does not remain on the previous field when the user taps to change focus
  int lastTextFieldIndex = 0;

  @override
  Widget build(BuildContext context) {
    final errorProvider = Provider.of<ErrorProvider>(context, listen: false);

    return SizedBox(
      height: 48,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          if (index % 2 == 0) {
            final textFieldIndex = index ~/ 2;
            final isFirstFieldError = errorProvider.errorTypeTimeTextField
                .contains(ErrorTypeEnums.firstTimeFieldError);
            final isSecondFieldError = errorProvider.errorTypeTimeTextField
                .contains(ErrorTypeEnums.thirdTimeFieldError);

            final borderColor = (isFirstFieldError && textFieldIndex == 0) ||
                    (isSecondFieldError && textFieldIndex == 2)
                ? constants.Colors.red
                : constants.Colors.greyLight;

            return Container(
              width: 44,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: widget.focusNodesList[textFieldIndex].hasFocus
                      ? constants.Colors.purple
                      : borderColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                left: 3,
              ),
              child: SizedBox(
                height: 24,
                child: RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (RawKeyEvent event) {
                    if (event is RawKeyDownEvent) {
                      if (event.logicalKey == LogicalKeyboardKey.backspace) {
                        setState(() {
                          widget.focusNodesList[lastTextFieldIndex].unfocus();
                        });

                        switchToPreviousTextField(
                          context: context,
                          currentIndex: textFieldIndex,
                        );

                        errorProvider.checkTimeTextFieldValue(
                          firstFieldController: widget.controllersList[0],
                          thirdFieldController: widget.controllersList[2],
                        );
                      }
                    }
                  },
                  child: TextField(
                    controller: widget.controllersList[textFieldIndex],
                    maxLength: 2,
                    textAlign: TextAlign.center,
                    scrollPadding: const EdgeInsets.all(0),
                    keyboardType: TextInputType.number,
                    focusNode: widget.focusNodesList[textFieldIndex],
                    style: constants.Styles.robotoBoldDarkS16W700,
                    cursorHeight: 20,
                    cursorWidth: 2,
                    onTap: () {
                      setState(() {
                        widget.focusNodesList[lastTextFieldIndex].unfocus();
                      });

                      // when you click on the text field, place the cursor at the end of the text
                      widget.controllersList[textFieldIndex].selection =
                          TextSelection.fromPosition(
                        TextPosition(
                            offset: widget
                                .controllersList[textFieldIndex].text.length),
                      );

                      if (!widget.focusNodesList[textFieldIndex].hasFocus) {
                        // If the element is not in focus, request focus
                        FocusScope.of(context).requestFocus(
                            widget.focusNodesList[textFieldIndex]);
                      }
                    },
                    onChanged: (value) {
                      String formattedValue;
                      if (value.isNotEmpty) {
                        if (value.length == 2) {
                          formattedValue = value.substring(1);
                          final textController =
                              widget.controllersList[textFieldIndex];
                          textController.text = formattedValue;
                        } else {
                          formattedValue = value;
                        }

                        errorProvider.checkTimeTextFieldValue(
                          firstFieldController: widget.controllersList[0],
                          thirdFieldController: widget.controllersList[2],
                        );

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

                      widget.onChanged(value);
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    cursorColor: constants.Colors.mainDark,
                    decoration: const InputDecoration(
                      counterText: "",
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: InputBorder.none,
                    ),
                  ),
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
    if (currentIndex < widget.controllersList.length - 1) {
      FocusScope.of(context)
          .requestFocus(widget.focusNodesList[currentIndex + 1]);
      lastTextFieldIndex = currentIndex + 1;
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  void switchToPreviousTextField(
      {required BuildContext context, required int currentIndex}) {
    if (currentIndex > 0) {
      FocusScope.of(context)
          .requestFocus(widget.focusNodesList[currentIndex - 1]);
      lastTextFieldIndex = currentIndex - 1;
    }
  }
}
