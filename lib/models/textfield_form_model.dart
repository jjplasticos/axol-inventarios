import 'package:axol_inventarios/models/validation_form_model.dart';

class TextfieldFormModel {
  String value;
  int position;
  ValidationFormModel validation;

  TextfieldFormModel({
    required this.position,
    required this.validation,
    required this.value,
  });

  TextfieldFormModel.empty()
      : position = 0,
        validation = ValidationFormModel.trueValid(),
        value = '';

  static const String pValue = 'value';
  static const String pPosition = 'position';
  static const String pValidation = 'validation';
}
