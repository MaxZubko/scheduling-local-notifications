import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/enums/error_type_enums/error_type_enums.dart';
import 'package:scheduling_local_notifications_app/features/utils/helpers/notify_id_helper.dart';
import 'package:scheduling_local_notifications_app/models/models.dart';
import 'package:scheduling_local_notifications_app/state/providers/error_provider.dart';
import 'package:scheduling_local_notifications_app/widgets/widgets.dart';

import '../../../services/services.dart';
import '../../../state/state.dart';

import 'package:get_it/get_it.dart';

class AddNewNotifyScreenBody extends StatefulWidget {
  final int? recurring;
  const AddNewNotifyScreenBody({
    super.key,
    this.recurring,
  });

  @override
  State<AddNewNotifyScreenBody> createState() => _AddNewNotifyScreenBodyState();
}

class _AddNewNotifyScreenBodyState extends State<AddNewNotifyScreenBody> {
  final TextEditingController _controllerMessage = TextEditingController();
  final FocusNode _focusNodeMessage = FocusNode();

  late List<TextEditingController> _controllersTimeList;
  late List<FocusNode> _focusNodesTimeList;

  bool isDisableBtn = true;

  @override
  void initState() {
    super.initState();

    _controllersTimeList = List.generate(4, (index) => TextEditingController());
    _focusNodesTimeList = List.generate(4, (index) => FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SwitchProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 34),
              child: Consumer<NewNotificationProvider>(
                builder: (context, newNotifyProvider, _) {
                  return Consumer<ErrorProvider>(
                    builder: (context, errorProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: MessageTextField(
                              controller: _controllerMessage,
                              focusNode: _focusNodeMessage,
                              onChanged: () {
                                checkDisableBtn(errorProvider);

                                if (widget.recurring != null) {
                                  saveTime(
                                    newNotifyProvider: newNotifyProvider,
                                    errorProvider: errorProvider,
                                  );
                                }
                              },
                            ),
                          ),
                          if (widget.recurring == null) ...[
                            const SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: _typeTimeWidget(
                                controllersList: _controllersTimeList,
                                focusNodesList: _focusNodesTimeList,
                                provider: newNotifyProvider,
                                errorProvider: errorProvider,
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SelectIconWidget(
                              selectedNotifyBackColor:
                                  newNotifyProvider.notifyBackColor,
                              selectedNotifyIcon:
                                  newNotifyProvider.notifyIconPath,
                              onNotifyBackColorSelected: (color) {
                                newNotifyProvider.setNotifyBackColor(color);
                              },
                              onNotifyIconSelected: (iconPath) {
                                newNotifyProvider.setNotifyIcon(iconPath);
                              },
                              onSavedIcon: () {},
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(height: 50),
                          ),
                          ErrorsWidget(
                            error: errorProvider.errorType.errorMessage,
                            isError: errorProvider.isError,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: DefaultButton(
                              title: 'Confirm',
                              isDisableBtn: isDisableBtn,
                              onPressed: () {
                                if (!errorProvider.isError) {
                                  addNotify(
                                    newNotifyProvider: newNotifyProvider,
                                    provider: provider,
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _typeTimeWidget({
    required List<TextEditingController> controllersList,
    required List<FocusNode> focusNodesList,
    required NewNotificationProvider provider,
    required ErrorProvider errorProvider,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Type time',
          style: constants.Styles.robotoDarkS14W500,
        ),
        const SizedBox(height: 6),
        CustomTimeTextFieldWidget(
          controllersList: controllersList,
          focusNodesList: focusNodesList,
          onChanged: (value) {
            if (isAllTimeFieldsFilled) {
              saveTime(
                newNotifyProvider: provider,
                errorProvider: errorProvider,
              );
            } else {
              errorProvider.setError(ErrorTypeEnums.none, false);
            }

            checkDisableBtn(errorProvider);
          },
        ),
      ],
    );
  }

  void checkDisableBtn(ErrorProvider errorProvider) {
    if (isMessageFieldFilled &&
        isAllTimeFieldsFilled &&
        !errorProvider.isError) {
      isDisableBtn = false;
    } else if (!isDisableBtn) {
      isDisableBtn = true;
    }

    setState(() {});
  }

  bool get isMessageFieldFilled {
    return _controllerMessage.text.isNotEmpty;
  }

  bool get isAllTimeFieldsFilled {
    return widget.recurring == null
        ? _controllersTimeList.every((controller) => controller.text.isNotEmpty)
        : true;
  }

  bool saveTime({
    required NewNotificationProvider newNotifyProvider,
    required ErrorProvider errorProvider,
  }) {
    try {
      final DateTime now = DateTime.now();

      if (widget.recurring == null) {
        int firstNumber = int.parse(_controllersTimeList[0].text);
        int secondNumber = int.parse(_controllersTimeList[1].text);
        int thirdNumber = int.parse(_controllersTimeList[2].text);
        int fourthNumber = int.parse(_controllersTimeList[3].text);

        final int hour = firstNumber * 10 + secondNumber;
        final int minutes = thirdNumber * 10 + fourthNumber;

        final DateTime enteredTime = DateTime(
          now.year,
          now.month,
          now.day,
          hour,
          minutes,
          now.second,
          now.millisecond,
        );

        // if (hour > 23 && minutes > 59) {
        //   errorProvider.setError(ErrorTypeEnums.incorrectTime, true);
        // } else
        if (enteredTime.isBefore(now)) {
          errorProvider.setError(ErrorTypeEnums.pastDate, true);
        }

        final int timestamp = enteredTime.millisecondsSinceEpoch;

        final String formattedEnteredTime =
            DateFormat('HH:mm').format(enteredTime);

        newNotifyProvider.setNotifyTime(
          time: formattedEnteredTime,
          timestamp: timestamp,
        );
      } else {
        final int timestamp = now.millisecondsSinceEpoch;

        newNotifyProvider.setNotifyTime(
          time: getTimeForRecurringNotify,
          timestamp: timestamp,
        );
      }

      return true;
    } catch (_) {
      return false;
    }
  }

  String get getTimeForRecurringNotify {
    if (widget.recurring! > 1) {
      return 'every ${widget.recurring} minutes';
    } else {
      return 'every ${widget.recurring} minute';
    }
  }

  Future<void> addNotify({
    required NewNotificationProvider newNotifyProvider,
    required SwitchProvider provider,
  }) async {
    final database = GetIt.I<DatabaseMethods>();

    if (newNotifyProvider.notifyTime.isNotEmpty) {
      bool isOnTimeNotify = provider.isOnTimeSelected;
      List<int> idList = widget.recurring != null
          ? generatingIdForNotifications(
              notifyTimestamp: newNotifyProvider.notifyTimestamp)
          : [
              GetIt.I<NotifyIdHelper>().creatingIdForNotify(
                timestamp: newNotifyProvider.notifyTimestamp,
              ),
            ];

      await database
          .addNotification(
        NotifyModel(
          time: newNotifyProvider.notifyTime,
          message: _controllerMessage.text,
          iconPath: newNotifyProvider.notifyIconPath,
          isOneTime: isOnTimeNotify,
          notifyBackgroundColors: newNotifyProvider.notifyBackColor,
          timestamp: newNotifyProvider.notifyTimestamp,
          idList: idList,
          recurring: widget.recurring,
        ),
      )
          .then(
        (value) async {
          await GetIt.I<LocalNotificationService>()
              .showScheduleNotification(
                title: 'test',
                body: _controllerMessage.text,
                payload: '',
                timestamp: newNotifyProvider.notifyTimestamp,
                recurring: widget.recurring,
                idList: idList,
              )
              .then(
                (value) => AutoRouter.of(context).pop(),
              );
        },
      );
    }
  }

  List<int> generatingIdForNotifications({required int notifyTimestamp}) {
    List<int> idList = [];

    for (int i = 0; i < constants.Values.repeatNotification; i++) {
      idList.add(
        GetIt.I<NotifyIdHelper>().creatingIdForNotify(
          timestamp: notifyTimestamp,
        ),
      );
    }

    return idList;
  }
}
