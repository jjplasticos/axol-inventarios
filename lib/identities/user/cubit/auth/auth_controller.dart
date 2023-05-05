import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view/pages/admin_page.dart';
import '../../view/pages/login_page.dart';
import '../../view/views/home_view.dart';
import '../../view/views/splash_view.dart';
import 'auth_cubit.dart';
import 'auth_state.dart';

class AuthController extends StatelessWidget {
  const AuthController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: BlocProvider.of<AuthCubit>(context)..getUserState(),
      builder: (BuildContext context, AuthState state) {
        if (state is AuthLoadingState) {
          return const SplashView();
        } else if (state is AuthAuthenticatedState) {
          final rol = state.user.rol;
          if (rol == 'admin') {
            return AdminPage(
              user: state.user,
            );
          } else if (rol == 'vendor') {
            return const HomeView();
          } else {
            return const Text('Error: no entro a ni una pagina.');
          }
        } else if (state is AuthUnuauthenticatedState) {
          return const Center(child: LoginPage());
        } else if (state is AuthErrorState) {
          return Center(
            child: Text(state.toString()),
          );
        } else {
          return const Center(
            child: Text('Error: no se recibió estado.'),
          );
        }
      },
    );
  }
}
