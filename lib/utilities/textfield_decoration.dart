import 'package:flutter/material.dart';

import 'theme/theme.dart';

class TextFieldDecoration {
  static InputDecoration decorationFinder() => InputDecoration(
        hintText: 'Buscar',
        hintStyle: Typo.hintText,
        border: InputBorder.none,
      );

  static InputDecoration inputForm(String? errorText) => InputDecoration(
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorPalette.primary),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorPalette.lightItems),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorPalette.caution),
    ),
    errorText: errorText,
  );
}
