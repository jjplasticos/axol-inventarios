import 'package:flutter/material.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../global_widgets/plugins_bar.dart';
import '../../../../global_widgets/toolbar.dart';
import '../../../../global_widgets/views_bar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../settings/theme.dart';
import '../../../user/view/views/home_view.dart';
import '../widgets/table_warehouse.dart';
import 'warehouse_menu_view.dart';

class WarehouseView extends StatelessWidget {
  const WarehouseView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'View de almacén';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PluginsBar(listData: [
              ElementsBarModel(
                  text: null,
                  icon: const Icon(Icons.home, color: Colors.white70),
                  action: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeView()));
                  }),
              ElementsBarModel(
                  text: null,
                  icon: const Icon(Icons.inventory, color: Colors.white70),
                  action: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WarehouseMenuView()));
                  }),
              ElementsBarModel(
                  text: null,
                  icon: const Icon(Icons.note, color: Colors.white70),
                  action: () {})
            ]),
            ViewsBar(
              listData: [
                ElementsBarModel(
                    icon: Icon(Icons.house_siding),
                    text: 'Multialmacen',
                    action: () {}),
                ElementsBarModel(
                    icon: Icon(Icons.move_down),
                    text: 'Movimientos',
                    action: () {}),
                ElementsBarModel(
                    text: 'Productos',
                    icon: Icon(Icons.grid_view_sharp),
                    action: () {})
              ],
            ),
            Expanded(
                child: TableWarehouse(
              listData: [],
            )),
            Toolbar(
              listData: [],
            )
          ],
        ),
      ),
    );
  }
}
