import 'package:flutter/material.dart';

import 'theme.dart';

class TextFieldDecoration {
  static InputDecoration decorationFinder() => InputDecoration(
        hintText: 'Buscar',
        hintStyle: Typo.hintText,
        border: InputBorder.none,
      );
}
