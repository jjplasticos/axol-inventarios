import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/login/controllers/login_txt_cubit.dart';
import '../../cubit/login/controllers/password_visibility/password_visibility_cubit.dart';
import '../../cubit/login/login/login_cubit.dart';
import '../views/login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => PasswordVisibilityCubit()),
        BlocProvider(create: (_) => PasswordTxtCubit()),
        BlocProvider(create: (_) => UserTxtCubit()),
      ],
      child: const LoginView(),
    );
  }
}
