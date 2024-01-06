import 'package:flutter/material.dart';

import '../../utilities/theme/theme.dart';

class IconButtonReturn extends StatelessWidget {
  final String? iconName;

  const IconButtonReturn({super.key, required this.iconName});

  @override
  Widget build(BuildContext context) {
    if (iconName == 'return') {
      return IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorPalette.lightText,
            size: 30,
          ));
    } else if (iconName == 'menu') {
      return IconButton(
          onPressed: () {
            Navigator.pop(context);
            //LocalShoppingcart().clearShoppingCart();
          },
          icon: const Icon(
            Icons.menu,
            color: ColorPalette.lightText,
            size: 30,
          ));
    } else {
      return IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.error,
            color: ColorPalette.lightText,
            size: 30,
          ));
    }
  }
}
