import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../../global_widgets/plugins_bar.dart';
import '../../../../../global_widgets/toolbar.dart';
import '../../../../../global_widgets/views_bar.dart';
import '../../../../../models/elemnets_bar_model.dart';
import '../../../../../models/user_mdoel.dart';
import '../../../../../settings/theme.dart';
import '../../../movements/view/views/movements_view.dart';
import '../../../../sale_note/view/views/sale_note_view.dart';
import '../../../../user/view/views/home_view.dart';
import '../../../product/view/views/product_view.dart';
import '../../../route_customers/view/views/routecustomers_view.dart';
import '../../cubit/inventory_load/inventory_load_cubit.dart';
import '../../cubit/textfield_finder_invrow_cubit.dart';
import '../../model/warehouse_model.dart';
import '../controllers/listview_warehouse_controller.dart';

import '../widgets/textfield_finder_inventoryrow.dart';
import 'inventory_movement_view.dart';
import 'warehouse_menu_view.dart';

class WarehouseView extends StatelessWidget {
  final WarehouseModel warehouse;
  final List<UserModel> users;
  const WarehouseView(
      {super.key, required this.warehouse, required this.users});

  @override
  Widget build(BuildContext context) {
    const String title = 'View de almacén';
    final double screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => InventoryLoadCubit()),
        BlocProvider(create: (_) => TextfieldFinderInvrowCubit()),
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
                    text: null,
                    icon: const Icon(Icons.note),
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
              Expanded(
                  child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const Text(
                          'Almacén: ',
                          style: Typo.bodyText5,
                        ),
                        Text(
                          warehouse.name,
                          style: Typo.bodyText5,
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: screenWidth > 650 ? screenWidth - 460 : 190,
                          child: TextfieldFinderInventroyrow(
                              inventoryName: warehouse.name),
                        )
                      ],
                    ),
                  ),
                  ListviewWarehouseController(
                    warehouseName: warehouse.name,
                  ),
                ],
              )),
              Toolbar(
                listData: [
                  ElementsBarModel(
                    text: null,
                    icon: const Icon(Icons.add),
                    action: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InventoryMovementView(
                                    warehouse: warehouse,
                                  )));
                    },
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
