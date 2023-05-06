import 'package:flutter/material.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../global_widgets/plugins_bar.dart';
import '../../../../global_widgets/views_bar.dart';
import '../../../../models/viewsbar_model.dart';
import '../../../../settings/theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'Inicio';
    List<ViewsbarModel> list = [];

    return Scaffold(
      backgroundColor: ColorPalette.primaryBackground,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarGlobal(
          title: title,
          iconButton: null,
          iconActions: [],
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            PluginsBar(),
            ViewsBar(
              listData: [
                ViewsbarModel(
                    icon: Icon(Icons.house_siding), text: 'Multialmacen'),
                ViewsbarModel(icon: Icon(Icons.move_down), text: 'Movimientos'),
                ViewsbarModel(
                    text: 'Productos', icon: Icon(Icons.grid_view_sharp))
              ],
            ),
            Expanded(
                child: Container(
              color: Colors.black38,
            ))
          ],
        ),
      ),
    );
  }
}
