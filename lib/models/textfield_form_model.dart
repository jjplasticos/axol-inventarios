import 'package:axol_inventarios/models/validation_form_model.dart';
import 'package:flutter/material.dart';

class TextfieldFormModel {
  TextEditingController controller;
  String key;
  String tag;
  String value;
  int position;
  ValidationFormModel validation;
  bool isLoading;
  FocusNode focusNode;

  TextfieldFormModel({
    required this.position,
    required this.validation,
    required this.value,
    required this.key,
    required this.controller,
    required this.isLoading,
    required this.tag,
    required this.focusNode,
  });

  TextfieldFormModel.empty()
      : position = 0,
        validation = ValidationFormModel.trueValid(),
        value = '',
        key = '',
        controller = TextEditingController(),
        isLoading = false,
        tag = '',
        focusNode = FocusNode();

  TextfieldFormModel.initKey({
    required this.key,
    required this.tag,
  })  : position = 0,
        validation = ValidationFormModel.trueValid(),
        value = '',
        controller = TextEditingController(),
        isLoading = false,
        focusNode = FocusNode();

  static const String pValue = 'value';
  static const String pPosition = 'position';
  static const String pValidation = 'validation';
}
