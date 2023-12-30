import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../../global_widgets/navigation_utilities.dart';
import '../../../../../global_widgets/plugins_bar.dart';
import '../../../../../global_widgets/views_bar.dart';
import '../../../../../models/elemnets_bar_model.dart';
import '../../../../../utilities/theme.dart';
import '../../../inventory/view/views/warehouse_menu_view.dart';
import '../../../movements/view/views/movements_view.dart';
import '../../../../sale_note/view/views/sale_note_view.dart';
import '../../../../user/view/views/home_view.dart';
import '../../../route_customers/view/views/routecustomers_view.dart';
import '../../cubit/products/products_cubit.dart';
import '../controllers/listview_products_controller.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductsCubit()),
      ],
      child: Scaffold(
        backgroundColor: ColorPalette.primaryBackground,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarGlobal(
            title: 'Productos',
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
                backgroundColor: ColorPalette.primaryBackground,
                indicatorColor: ColorPalette.primary,
                useIndicator: true,
                onDestinationSelected: (value) {
                  if (value == 0) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeView()));
                  }
                  if (value == 2) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SaleNoteView()));
                  }
                },
              ),
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
                      action: () {}),
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
              const Expanded(child: ListviewProductsController()),
            ],
          ),
        ),
      ),
    );
  }
}
