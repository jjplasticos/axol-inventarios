import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../settings/theme.dart';
import '../../cubit/login_txt_cubit.dart';

class TextFieldUser extends StatelessWidget {
  const TextFieldUser({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        context.read<UserTxtCubit>().change(value);
      },
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Usuario',
        hintStyle: Typo.hintText,
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: ColorPalette.secondaryBackground,
      ),
    );
  }
}
