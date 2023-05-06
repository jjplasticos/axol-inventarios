import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../settings/theme.dart';
import '../../cubit/login_txt_cubit.dart';
import '../../cubit/password_visibility/password_visibility_controller.dart.dart';
import '../controllers/password_visibility_cubit.dart';
import '../../cubit/password_visibility/password_visibility_state.dart';

class TextFieldPassword extends StatelessWidget {
  const TextFieldPassword({super.key});

  @override
  Widget build(BuildContext context) {
    bool obs = true;

    return BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: obs,
          onChanged: (value) {
            context.read<PasswordTxtCubit>().change(value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hintText: 'Contraseña',
            hintStyle: Typo.hintText,
            suffixIcon: IconButton(
              icon: const PasswordVisibilityController(),
              onPressed: () async {
                context.read<PasswordVisibilityCubit>().visibility();
                obs = await context.read<PasswordVisibilityCubit>().isVisible();
              },
            ),
            filled: true,
            fillColor: ColorPalette.secondaryBackground,
          ),
        );
      },
    );
  }
}
