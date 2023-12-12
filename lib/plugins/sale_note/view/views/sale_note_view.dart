import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../global_widgets/plugins_bar.dart';
import '../../../../global_widgets/views_bar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../utilities/theme.dart';
import '../../../inventory_/inventory/view/views/warehouse_menu_view.dart';
import '../../../user/view/views/home_view.dart';
import '../../cubit/finder_notes_cubit.dart';
import '../../cubit/sale_note_cubit/salenote_cubit.dart';
import '../controllers/listview_notes_controller.dart';

class SaleNoteView extends StatelessWidget {
  const SaleNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SalenoteCubit()),
        BlocProvider(create: (_) => FinderNotesCubit()),
      ],
      child: Scaffold(
        backgroundColor: ColorPalette.primaryBackground,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarGlobal(
            title: 'Notas de venta',
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
                      icon: const Icon(Icons.insert_drive_file),
                      text: 'Notas de venta',
                      action: () {
                        /*Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const WarehouseMenuView()));*/
                      }),
                  ElementsBarModel(
                      icon: const Icon(Icons.insert_drive_file),
                      text: 'Remisiones',
                      action: () {
                        /* Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MovementsView()));*/
                      }),
                  ElementsBarModel(
                      text: 'Clientes',
                      icon: const Icon(Icons.people),
                      action: () {}),
                  ElementsBarModel(
                      text: 'Vendedores',
                      icon: const Icon(Icons.people),
                      action: () {}),
                ],
              ),
              const Expanded(child: ListviewNotesController()),
            ],
          ),
        ),
      ),
    );
  }
}
