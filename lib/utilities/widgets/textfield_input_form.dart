import 'package:axol_inventarios/utilities/textfield_decoration.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class TextFieldInputForm extends StatelessWidget {
  final String? label;
  final TextStyle? labelStyle;
  final double? space;
  final TextEditingController controller;
  final InputDecoration? decoration;
  final String? errorText;
  final TextStyle? style;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final bool? enabled;

  const TextFieldInputForm({
    super.key,
    required this.controller,
    this.label,
    this.labelStyle,
    this.space,
    this.decoration,
    this.errorText,
    this.style,
    this.onChanged,
    this.onSubmitted,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final labelTf = label ?? '';
    final labelStyleTf = labelStyle ?? Typo.bodyDark;
    final spaceTf = space ?? 8;
    final decorationTf = decoration ?? TextFieldDecoration.inputForm(errorText);
    final bool enabledTf = enabled ?? true;
    return Row(
      children: [
        Text(
          labelTf,
          style: labelStyleTf,
        ),
        SizedBox(
          width: spaceTf,
        ),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: decorationTf,
            enabled: enabledTf,
            style: style,
            onSubmitted: onSubmitted,
            onChanged: onChanged,
            cursorColor: ColorPalette.primary,
          ),
        ),
        /*SizedBox(
          height: 12,
          width: 12,
          child: Visibility(
            visible: isLoadingTf,
            child: const CircularProgressIndicator(
              backgroundColor: ColorPalette.lightBackground,
              color: ColorPalette.primary,
            ),
          ),
        ),*/
      ],
    );
  }
}
