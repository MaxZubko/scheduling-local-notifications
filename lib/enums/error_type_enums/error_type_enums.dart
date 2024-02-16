enum ErrorTypeEnums {
  firstTimeFieldError,
  thirdTimeFieldError,
  incorrectTime,
  pastDate,
  none,
}

extension ErrorTypeEnumsExtension on ErrorTypeEnums {
  String get errorMessage {
    switch (this) {
      case ErrorTypeEnums.firstTimeFieldError:
        return 'The number in the first field must be no more than two.';
      case ErrorTypeEnums.thirdTimeFieldError:
        return 'The number in the third field must be no more than five.';
      case ErrorTypeEnums.incorrectTime:
        return 'The time is wrong. Try again.';
      case ErrorTypeEnums.pastDate:
        return 'Date must be future';
      default:
        return '';
    }
  }
}
