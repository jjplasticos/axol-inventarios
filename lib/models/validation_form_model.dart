class ValidationFormModel {
  final bool isValid;
  final String errorMessage;

  ValidationFormModel({required this.isValid, required this.errorMessage});

  static ValidationFormModel trueValid() =>
      ValidationFormModel(isValid: true, errorMessage: '');
}
