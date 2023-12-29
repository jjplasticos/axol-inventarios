import 'package:flutter/material.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../global_widgets/plugins_bar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../utilities/theme.dart';
import '../../../inventory_/inventory/view/views/warehouse_menu_view.dart';
import '../../../sale_note/view/views/sale_note_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'Inicio';

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
            PluginsBar(listData: [
              ElementsBarModel(
                  text: null, icon: const Icon(Icons.home), action: () {}),
              ElementsBarModel(
                  text: null,
                  icon: const Icon(Icons.inventory),
                  action: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WarehouseMenuView()));
                  }),
              ElementsBarModel(
                  text: null, icon: const Icon(Icons.note), action: () {
                    Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SaleNoteView()));
                  })
            ]),
            /*ViewsBar(
              listData: [
                ElementsBarModel(
                    icon: const Icon(Icons.house_siding),
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
                child: Container(
              color: Colors.black38,
            )),
            Toolbar(
              listData: [],
            )*/
          ],
        ),
      ),
    );
  }
}
