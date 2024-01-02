import 'package:flutter/material.dart';

import '../theme.dart';

class AlertDialogAxol extends StatelessWidget {
  final String text;
  const AlertDialogAxol({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.warning,
        color: ColorPalette.error,
      ),
      content: Text(
        text,
        style: Typo.bodyDark,
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
              backgroundColor: ColorPalette.primary,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)))),
          child: const Text(
            'Aceptar',
            style: Typo.textButton,
          ),
        ),
      ],
    );
  }
}
