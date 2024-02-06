import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scheduling_local_notifications_app/features/auth_screen/auth.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/state/state.dart';
import 'package:scheduling_local_notifications_app/widgets/widgets.dart';

class AuthScreenBody extends StatefulWidget {
  const AuthScreenBody({super.key});

  @override
  State<AuthScreenBody> createState() => _AuthScreenBodyState();
}

class _AuthScreenBodyState extends State<AuthScreenBody> {
  late List<TextEditingController> controllers;

  late List<FocusNode> focusNodes;

  final DateTime currentTime = DateTime.now();
  late String formattedCurrentTime = DateFormat('HH:mm').format(currentTime);

  bool isDisableBtn = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(4, (index) => TextEditingController());
    focusNodes = List.generate(4, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const SizedBox(height: 72),
                const Text(
                  'Log In',
                  style: constants.Styles.robotoDarkS24W700,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter current time in hh : mm format',
                  style: constants.Styles.robotoGreyDarkS16W400,
                ),
                const SizedBox(height: 42),
                Text(
                  formattedCurrentTime,
                  style: constants.Styles.robotoDarkS32W700,
                ),
                const SizedBox(height: 42),
                Align(
                  child: CustomTimeTextFieldWidget(
                    controllersList: controllers,
                    focusNodesList: focusNodes,
                    onChanged: (value) {
                      if (isAllFieldsFilled) {
                        isDisableBtn = !isAllFieldsFilled;
                      } else if (!isDisableBtn) {
                        isDisableBtn = true;
                      }

                      if (isError) {
                        isError = false;
                      }

                      setState(() {});
                    },
                  ),
                ),
                const Expanded(
                  child: SizedBox(height: 50),
                ),
                errorWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultButton(
                    title: 'Confirm',
                    isDisableBtn: isDisableBtn,
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      submitForm();
                    },
                  ),
                ),
                const SizedBox(height: 34),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget errorWidget() {
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
              const Text(
                'The time is wrong. Try again.',
                style: constants.Styles.robotoRedS14W500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get isAllFieldsFilled {
    return controllers.every((controller) => controller.text.isNotEmpty);
  }

  bool get isInputTimeValid {
    try {
      int firstNumber = int.parse(controllers[0].text);
      int secondNumber = int.parse(controllers[1].text);
      int thirdNumber = int.parse(controllers[2].text);
      int fourthNumber = int.parse(controllers[3].text);

      final int hour = firstNumber * 10 + secondNumber;
      final int minutes = thirdNumber * 10 + fourthNumber;

      final DateTime enteredTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        hour,
        minutes,
      );
      final String formattedEnteredTime =
          DateFormat('HH:mm').format(enteredTime);

      return formattedCurrentTime == formattedEnteredTime;
    } catch (e) {
      return false;
    }
  }

  void submitForm() {
    if (isAllFieldsFilled && isInputTimeValid) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      Future.delayed(const Duration(milliseconds: 100), () {
        authProvider.login(true);
      });
    } else {
      setState(() {
        isError = true;
      });
    }
  }
}
