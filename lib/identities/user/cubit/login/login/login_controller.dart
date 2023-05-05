import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view/pages/admin_page.dart';
import '../../../view/views/home_view.dart';
import 'login_cubit.dart';
import 'login_state.dart';

class LoginController extends StatelessWidget {
  const LoginController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is LoginFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Usuario o contraseña invalida.')));
        } else if (state is LoginSuccessState) {
          final rol = state.user.rol;
          if (rol == 'admin') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminPage(
                          user: state.user,
                        )));
          } else if (rol == 'vendor') {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeView()));
          }
        } else if (state is LoginErrorState) {
          if (kDebugMode) {
            print('LoginErrorState: ${state.error}');
          }
        }
      },
      bloc: context.read<LoginCubit>(),
      child: const Text(''),
    );
  }
}
