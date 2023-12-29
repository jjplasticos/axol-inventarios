import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../../global_widgets/plugins_bar.dart';
import '../../../../../global_widgets/views_bar.dart';
import '../../../../../models/elemnets_bar_model.dart';
import '../../../../../utilities/theme.dart';
import '../../../movements/view/views/movements_view.dart';
import '../../../product/view/views/product_view.dart';
import '../../../../sale_note/view/views/sale_note_view.dart';
import '../../../../user/view/views/home_view.dart';
import '../../../route_customers/view/views/routecustomers_view.dart';
import '../../cubit/warehouses_load/warehouses_load_cubit.dart';
import '../controllers/listview_whmenu_controller.dart';

class WarehouseMenuView extends StatelessWidget {
  const WarehouseMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'Menú de almacenes';
    return BlocProvider(
        create: (_) => WarehousesLoadCubit(),
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
                      action: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SaleNoteView()));
                      })
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
                        action: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MovementsView()));
                        }),
                    ElementsBarModel(
                        text: 'Productos',
                        icon: const Icon(Icons.grid_view_sharp),
                        action: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProductView()));
                        }),
                    ElementsBarModel(
                        text: 'Clientes de ruta',
                        icon: const Icon(Icons.people),
                        action: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RoutCustomers()));
                        }),
                  ],
                ),
                const Expanded(
                  child: ListviewWHMenuController(),
                ),
              ],
            ),
          ),
        ));
  }
}
