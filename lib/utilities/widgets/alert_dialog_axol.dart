import 'package:flutter/material.dart';

import '../theme/theme.dart';

class AlertDialogAxol extends StatelessWidget {
  final String text;
  final List<Widget>? actions;
  const AlertDialogAxol({super.key, required this.text, this.actions});

  @override
  Widget build(BuildContext context) {
    final List<Widget> actions_ = actions ??
        [
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
              style: Typo.bodyLight,
            ),
          ),
        ];
    return AlertDialog(
        icon: const Icon(
          Icons.warning,
          color: ColorPalette.caution,
          size: 40,
        ),
        content: Text(
          text,
          style: Typo.bodyDark,
        ),
        actions: actions_);
  }
}
