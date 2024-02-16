import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;
import 'package:scheduling_local_notifications_app/enums/error_type_enums/error_type_enums.dart';
import 'package:scheduling_local_notifications_app/models/models.dart';
import 'package:scheduling_local_notifications_app/state/providers/error_provider.dart';
import 'package:scheduling_local_notifications_app/widgets/widgets.dart';

import '../../../services/services.dart';
import '../../../state/state.dart';

import 'package:get_it/get_it.dart';

class EditNotifyScreenBody extends StatefulWidget {
  final int? recurring;
  final NotifyModel notify;
  const EditNotifyScreenBody({
    super.key,
    this.recurring,
    required this.notify,
  });

  @override
  State<EditNotifyScreenBody> createState() => _EditNotifyScreenBodyState();
}

class _EditNotifyScreenBodyState extends State<EditNotifyScreenBody> {
  final TextEditingController _controllerMessage = TextEditingController();
  final FocusNode _focusNodeMessage = FocusNode();

  late List<TextEditingController> _controllersTimeList;
  late List<FocusNode> _focusNodesTimeList;
  late NotifyModel _notifyModel;

  bool isDisableBtn = false;

  @override
  void initState() {
    super.initState();
    _notifyModel = widget.notify;
    _controllersTimeList = List.generate(4, (index) => TextEditingController());
    _focusNodesTimeList = List.generate(4, (index) => FocusNode());

    _controllerMessage.text = _notifyModel.message;
    _controllersTimeList = addingValuesToControllers(
      list: _controllersTimeList,
      notifyTime: _notifyModel.time,
    );
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
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 34),
              child: Consumer<EditNotificationProvider>(
                builder: (context, editNotifyProvider, _) {
                  if (editNotifyProvider.idList.isEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      editNotifyProvider.addNotifyInfo(_notifyModel);
                    });
                  }

                  return Consumer<ErrorProvider>(
                    builder: (context, errorProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MessageTextField(
                              controller: _controllerMessage,
                              focusNode: _focusNodeMessage,
                              onChanged: () {
                                checkDisableBtn(errorProvider);

                                if (widget.recurring != null) {
                                  saveTime(
                                    editNotifyProvider: editNotifyProvider,
                                    errorProvider: errorProvider,
                                  );
                                }
                              }),
                          if (widget.recurring == null) ...[
                            const SizedBox(height: 24),
                            _typeTimeWidget(
                              controllersList: _controllersTimeList,
                              focusNodesList: _focusNodesTimeList,
                              provider: editNotifyProvider,
                              time: _notifyModel.time,
                              errorProvider: errorProvider,
                            ),
                          ],
                          const SizedBox(height: 24),
                          SelectIconWidget(
                            selectedNotifyBackColor:
                                editNotifyProvider.notifyBackColor,
                            selectedNotifyIcon:
                                editNotifyProvider.notifyIconPath,
                            onNotifyBackColorSelected: (color) {
                              editNotifyProvider.setNotifyBackColor(color);
                            },
                            onNotifyIconSelected: (iconPath) {
                              editNotifyProvider.setNotifyIcon(iconPath);
                            },
                            onSavedIcon: () {},
                          ),
                          const Expanded(
                            child: SizedBox(height: 50),
                          ),
                          ErrorsWidget(
                            error: errorProvider.errorType.errorMessage,
                            isError: errorProvider.isError,
                          ),
                          DefaultButton(
                            title: 'Update',
                            isDisableBtn: isDisableBtn,
                            onPressed: () {
                              editNotify(
                                editNotifyProvider: editNotifyProvider,
                                provider: provider,
                              );
                            },
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
    required EditNotificationProvider provider,
    required String time,
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
                editNotifyProvider: provider,
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
    required EditNotificationProvider editNotifyProvider,
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

        if (hour > 23 && minutes > 59) {
          errorProvider.setError(ErrorTypeEnums.incorrectTime, true);
        } else if (enteredTime.isBefore(now)) {
          errorProvider.setError(ErrorTypeEnums.pastDate, true);
        }

        final int timestamp = enteredTime.millisecondsSinceEpoch;

        final String formattedEnteredTime =
            DateFormat('HH:mm').format(enteredTime);

        editNotifyProvider.setNotifyTime(
          time: formattedEnteredTime,
          timestamp: timestamp,
        );
      } else {
        final int timestamp = now.millisecondsSinceEpoch;

        editNotifyProvider.setNotifyTime(
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

  Future<void> editNotify({
    required EditNotificationProvider editNotifyProvider,
    required SwitchProvider provider,
  }) async {
    final database = GetIt.I<DatabaseMethods>();

    if (editNotifyProvider.notifyTime.isNotEmpty) {
      bool isOnTimeNotify = provider.isOnTimeSelected;

      await database
          .updateNotification(
        NotifyModel(
          time: editNotifyProvider.notifyTime,
          message: _controllerMessage.text,
          iconPath: editNotifyProvider.notifyIconPath,
          isOneTime: isOnTimeNotify,
          notifyBackgroundColors: editNotifyProvider.notifyBackColor,
          timestamp: editNotifyProvider.notifyTimestamp,
          idList: editNotifyProvider.idList,
          recurring: widget.recurring,
        ),
      )
          .then(
        (value) async {
          await GetIt.I<LocalNotificationService>()
              .cancelNotification(editNotifyProvider.idList);

          await GetIt.I<LocalNotificationService>()
              .showScheduleNotification(
                title: 'test',
                body: _controllerMessage.text,
                payload: '',
                timestamp: editNotifyProvider.notifyTimestamp,
                recurring: widget.recurring,
                idList: editNotifyProvider.idList,
              )
              .then(
                (value) => AutoRouter.of(context).pop(),
              );
        },
      );
    }
  }

  List<TextEditingController> addingValuesToControllers(
      {required List<TextEditingController> list, required String notifyTime}) {
    List<String> timeDigits =
        notifyTime.split('').where((char) => char != ':').toList();

    if (timeDigits.length == list.length) {
      for (int i = 0; i < timeDigits.length; i++) {
        list[i].text = timeDigits[i];
      }
    }
    return list;
  }
}
