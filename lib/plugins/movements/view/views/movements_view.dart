import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../global_widgets/plugins_bar.dart';
import '../../../../global_widgets/toolbar.dart';
import '../../../../global_widgets/views_bar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../settings/theme.dart';
import '../../../inventory/cubit/inventory_load/inventory_load_cubit.dart';
import '../../../inventory/view/views/warehouse_menu_view.dart';
import '../../../user/view/views/home_view.dart';
import '../widgets/listview_movements.dart';

class MovementsView extends StatelessWidget {
  const MovementsView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'View de movimientos';

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => InventoryLoadCubit()),
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
                              builder: (context) => const WarehouseMenuView()));
                    }),
                ElementsBarModel(
                    text: null, icon: const Icon(Icons.note), action: () {})
              ]),
              ViewsBar(
                listData: [
                  ElementsBarModel(
                      icon: const Icon(Icons.house_siding),
                      text: 'Multialmacen',
                      action: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const WarehouseMenuView()));
                      }),
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
                  child: ListviewMovements(
                movementsList: [],
              )),
              Toolbar(
                listData: [
                  ElementsBarModel(
                    text: null,
                    icon: const Icon(Icons.add),
                    action: () {},
                  ),
                  ElementsBarModel(
                    text: null,
                    icon: const Icon(Icons.filter_alt),
                    action: () {},
                  ),
                  ElementsBarModel(
                    text: null,
                    icon: const Icon(Icons.restart_alt),
                    action: () {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
