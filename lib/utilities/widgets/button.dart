import 'package:flutter/material.dart';

import '../theme.dart';

class ButtonDrawerSave extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final bool? isLoading;

  const ButtonDrawerSave({
    Key? key,
    this.onPressed,
    this.text,
    this.isLoading,
  }) : super(key: key);

  @override
  State createState() => _ButtonDrawerSave();
}

class _ButtonDrawerSave extends State<ButtonDrawerSave> {
  @override
  Widget build(BuildContext context) {
    final String fText = widget.text ?? 'Guardar';
    final Function() fOnPressed = widget.onPressed ?? () {};
    final bool isLoading_ = widget.isLoading ?? false;
    return OutlinedButton(
      onPressed: isLoading_ ? () {} : fOnPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor:
            isLoading_ ? ColorPalette.primary : ColorPalette.lightBackground,
        backgroundColor: ColorPalette.primary,
        side: BorderSide.none,
      ),
      child: Text(fText, style: Typo.bodyLight),
    );
  }
}

class ButtonDrawerReturn extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final bool? isLoading;

  const ButtonDrawerReturn({
    Key? key,
    this.onPressed,
    this.text,
    this.isLoading,
  }) : super(key: key);

  @override
  State createState() => _ButtonDrawerReturn();
}

class _ButtonDrawerReturn extends State<ButtonDrawerReturn> {
  @override
  Widget build(BuildContext context) {
    final String fText = widget.text ?? 'Regresar';
    final Function() fOnPressed = widget.onPressed ?? () {};
    final bool isLoading_ = widget.isLoading ?? false;
    return OutlinedButton(
      onPressed: isLoading_ ? () {} : fOnPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: ColorPalette.lightBackground,
        side: const BorderSide(color: ColorPalette.primary, width: 2),
        foregroundColor:
            isLoading_ ? ColorPalette.lightBackground : ColorPalette.primary,
      ),
      child: Text(fText, style: Typo.bodyDark),
    );
  }
}
