import 'package:flutter/material.dart';
import '../../cubit/login/login/login_controller.dart';

import '../../../../settings/theme.dart';
import '../widgets/button_login.dart';
import '../widgets/logo.dart';
import '../widgets/text_field_password.dart';
import '../widgets/text_field_user.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(),
            SizedBox(
              width: double.infinity,
              height: 210,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
                    child: TextFieldUser(),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
                    child: TextFieldPassword(),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
                    child: ButtonLogin(),
                  ),
                  LoginController(),
                ],
              ),
            )
          ],
        ));
  }
}
