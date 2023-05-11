import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../global_widgets/plugins_bar.dart';
import '../../../../global_widgets/toolbar.dart';
import '../../../../global_widgets/views_bar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../settings/theme.dart';
import '../../../user/view/views/home_view.dart';
import '../../cubit/inventory_load/inventory_load_cubit.dart';
import '../controllers/listview_warehouse_controller.dart';

import 'warehouse_menu_view.dart';

class WarehouseView extends StatelessWidget {
  final String warehouseName;
  const WarehouseView({super.key, required this.warehouseName});

  @override
  Widget build(BuildContext context) {
    const String title = 'View de almacén';

    return BlocProvider(
        create: (_) => InventoryLoadCubit(),
        child: Scaffold(
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
                      icon: const Icon(Icons.home),
                      action: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeView()));
                      }),
                  ElementsBarModel(
                      text: null,
                      icon: const Icon(Icons.inventory),
                      action: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const WarehouseMenuView()));
                      }),
                  ElementsBarModel(
                      text: null, icon: const Icon(Icons.note), action: () {})
                ]),
                ViewsBar(
                  listData: [
                    ElementsBarModel(
                        icon: const Icon(Icons.house_siding),
                        text: 'Multialmacen',
                        action: () {}),
                    ElementsBarModel(
                        icon: const Icon(Icons.move_down),
                        text: 'Movimientos',
                        action: () {}),
                    ElementsBarModel(
                        text: 'Productos',
                        icon: const Icon(Icons.grid_view_sharp),
                        action: () {})
                  ],
                ),
                Expanded(
                    child: ListviewWarehouseController(
                  warehouseName: warehouseName,
                )),
                Toolbar(
                  listData: [
                    ElementsBarModel(
                      text: null,
                      icon: const Icon(Icons.add),
                      action: () {},
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
