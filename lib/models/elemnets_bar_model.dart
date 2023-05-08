import 'package:flutter/material.dart';

class ElementsBarModel {
  final String? text;
  final Icon? icon;
  final void Function()? action;

  ElementsBarModel(
      {required this.text, required this.icon, required this.action});
}
