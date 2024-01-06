import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../../utilities/navigation_utilities.dart';
import '../../../../../utilities/theme.dart';
import '../../../movements/cubit/movements_view/movements_cubit.dart';
import '../../../movements/view/controllers/listview_movements_controller.dart';
import '../../../product/cubit/products/products_cubit.dart';
import '../../../product/view/controllers/listview_products_controller.dart';
import '../../../../sale/view/sale_view.dart';
import '../../../../user/view/views/home_view.dart';
import '../../cubit/warehouses_load/warehouses_load_cubit.dart';
import '../controllers/listview_whmenu_controller.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'Menú de almacenes';
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MovementsCuibit()),
          BlocProvider(create: (_) => WarehousesLoadCubit()),
          BlocProvider(create: (_) => ProductsCubit()),
        ],
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: ColorPalette.darkBackground,
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
                    NavigationRail(
                      destinations: NavigationUtilities.navRail,
                      selectedIndex: 1,
                      backgroundColor: ColorPalette.darkBackground,
                      indicatorColor: ColorPalette.primary,
                      useIndicator: true,
                      onDestinationSelected: (value) {
                        if (value == 0) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeView()));
                        }
                        if (value == 2) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SaleView()));
                        }
                      },
                    ),
                    const VerticalDivider(
                        thickness: 1, width: 1, color: ColorPalette.darkItems),
                    const Expanded(
                        child: Column(
                      children: [
                        TabBar(
                          indicatorColor: ColorPalette.primary,
                          tabs: [
                            Tab(
                              text: 'Multialmacen',
                            ),
                            Tab(
                              text: 'Movimientos',
                            ),
                            Tab(
                              text: 'Productos',
                            ),
                          ],
                        ),
                        Expanded(
                            child: TabBarView(children: [
                          ListviewWHMenuController(),
                          ListviewMovementsController(),
                          ListviewProductsController(),
                        ]))
                      ],
                    )),
                  ],
                ),
              ),
            )));
  }
}
