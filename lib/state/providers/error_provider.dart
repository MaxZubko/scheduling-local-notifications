import 'package:flutter/material.dart';
import 'package:scheduling_local_notifications_app/enums/error_type_enums/error_type_enums.dart';

class ErrorProvider extends ChangeNotifier {
  bool _isError = false;
  ErrorTypeEnums _errorType = ErrorTypeEnums.none;
  final List<ErrorTypeEnums> _errorTypeListTimeTextField = [
    ErrorTypeEnums.none
  ];

  bool get isError => _isError;
  ErrorTypeEnums get errorType => _errorType;
  List<ErrorTypeEnums> get errorTypeTimeTextField =>
      _errorTypeListTimeTextField;

  void setError(ErrorTypeEnums errorType, bool isError) {
    _isError = isError;
    _errorType = errorType;
    notifyListeners();
  }

  void checkTimeTextFieldValue({
    required TextEditingController firstFieldController,
    required TextEditingController thirdFieldController,
  }) {
    final String firstControllerText = firstFieldController.text;
    final String thirdControllerText = thirdFieldController.text;

    if (firstControllerText.isNotEmpty && int.parse(firstControllerText) > 2) {
      setError(ErrorTypeEnums.firstTimeFieldError, true);

      // we check that there are no duplicates
      if (!_errorTypeListTimeTextField
          .contains(ErrorTypeEnums.firstTimeFieldError)) {
        _errorTypeListTimeTextField.add(ErrorTypeEnums.firstTimeFieldError);
      }
    } else if (_errorTypeListTimeTextField
        .contains(ErrorTypeEnums.firstTimeFieldError)) {
      _errorTypeListTimeTextField.remove(ErrorTypeEnums.firstTimeFieldError);

      // if there is 1 element in the list it is ErrorTypeEnums.none
      if (_errorTypeListTimeTextField.length == 1) {
        setError(ErrorTypeEnums.none, false);
      }
    }

    if (thirdControllerText.isNotEmpty && int.parse(thirdControllerText) > 5) {
      setError(ErrorTypeEnums.thirdTimeFieldError, true);

      // we check that there are no duplicates
      if (!_errorTypeListTimeTextField
          .contains(ErrorTypeEnums.thirdTimeFieldError)) {
        _errorTypeListTimeTextField.add(ErrorTypeEnums.thirdTimeFieldError);
      }
    } else if (_errorTypeListTimeTextField
        .contains(ErrorTypeEnums.thirdTimeFieldError)) {
      _errorTypeListTimeTextField.remove(ErrorTypeEnums.thirdTimeFieldError);

      // if there is 1 element in the list it is ErrorTypeEnums.none
      if (_errorTypeListTimeTextField.length == 1) {
        setError(ErrorTypeEnums.none, false);
      }
    }

    if (firstControllerText.isEmpty && thirdControllerText.isEmpty) {
      clearError();
    }
  }

  void clearError() {
    _errorTypeListTimeTextField.clear();
    _errorTypeListTimeTextField.add(ErrorTypeEnums.none);
    setError(ErrorTypeEnums.none, false);
  }
}
