import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../global_widgets/plugins_bar.dart';
import '../../../../global_widgets/toolbar.dart';
import '../../../../global_widgets/views_bar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../settings/theme.dart';
import '../../../user/view/views/home_view.dart';
import '../../cubit/drawer_inventory_cubit.dart';
import '../../cubit/warehouse_setting/warehouse_setting_cubit.dart';
import '../../cubit/warehouses_load/warehouses_load_cubit.dart';
import '../controllers/drawer_warehouse_controller.dart';
import '../controllers/listview_whmenu_controller.dart';

class WarehouseMenuView extends StatelessWidget {
  const WarehouseMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'Menú de almacenes';
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => WarehousesLoadCubit()),
          //BlocProvider(create: (_) => DrawerInventoryCubit()),
          //BlocProvider(create: (_) => WarehouseSettingCubit()),
        ],
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
          /*drawer: state == 1
                  ? const Drawer(
                      key: Key('keyDrawer'),
                      child: Text('Un drawer abiert'),
                    )
                  : null,*/
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
                      action: () {}),
                  ElementsBarModel(
                      text: null,
                      icon: const Icon(Icons.note, color: Colors.white70),
                      action: () {})
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
                const Expanded(
                  child: ListviewWHMenuController(),
                ),
                Toolbar(
                  listData: [
                    ElementsBarModel(
                        text: null,
                        icon: const Icon(Icons.add),
                        action: () {
                          showDialog(
                              context: context,
                              builder: (context) => BlocProvider(
                                  create: (_) => WarehouseSettingCubit(),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        color: Colors.black26,
                                      )),
                                      const DrawerWarehouseController(
                                        settingMode: 0,
                                        users: [],
                                      ),
                                    ],
                                  )));
                          /*context
                                    .read<DrawerInventoryCubit>()
                                    .openDrawer();*/
                        }),
                    ElementsBarModel(
                      text: null,
                      icon: const Icon(Icons.edit_square),
                      action: () {},
                    ),
                    ElementsBarModel(
                      text: null,
                      icon: const Icon(Icons.delete),
                      action: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

/*class WarehouseMenuBuilder extends StatelessWidget {
  final String title;

  const WarehouseMenuBuilder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerInventoryCubit, bool>(
      bloc: context.read<DrawerInventoryCubit>()..closeDrawer(),
      builder: (context, state) {
        return Stack(
          children: [
            
            if (state)
              Row(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.black26,
                  )),
                  DrawerWarehouseController(
                    settingMode: 0,
                    users: [],
                    //back: context.read<DrawerInventoryCubit>(),
                  ),
                  /*Drawer(
                    width: 300,
                    child: OutlinedButton(child: Text('Regresar'), onPressed: (){
                      context.read<DrawerInventoryCubit>().closeDrawer();
                    }),
                  )*/
                ],
              )
          ],
        );
      },
    );
  }
}*/
