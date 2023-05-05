import 'package:flutter/material.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../global_widgets/appbar/iconbutton_return.dart';
import '../../../../global_widgets/main_bar.dart';
import '../../../../settings/theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'Inicio';

    return const Scaffold(
        backgroundColor: ColorPalette.primaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarGlobal(
            title: title,
            iconButton: null,
            iconActions: [],
          ),
        ),
        body: MainBar());
  }
}
