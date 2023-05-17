import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../global_widgets/toolbar.dart';
import '../../../../global_widgets/views_bar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../models/inventory_move_row_model.dart';
import '../../../../settings/theme.dart';
import '../../cubit/list_view_invmov_cubit.dart';
import '../../cubit/warehouses_load/warehouses_load_cubit.dart';
import '../controllers/listview_invmov_controller.dart';
import '../widgets/inventory_movement/lsitview_inventory_movement.dart';

class InventoryMovementView extends StatelessWidget {
  const InventoryMovementView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'Menú de almacenes';

    return MultiBlocProvider(
        providers: [
          //BlocProvider(create: (_) => WarehousesLoadCubit()),
          BlocProvider(create: (_) => ListviewInvMovCubit()),
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
          body: //ListviewInvMovController(),
              Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewsBar(
                listData: [
                  ElementsBarModel(
                      icon: const Icon(Icons.arrow_back),
                      text: 'Regresar',
                      action: () {
                        Navigator.of(context).pop();
                        print('object');
                      }),
                ],
              ),
              //const ListviewInvMovController(),
              const Expanded(
                child: ListviewInvMovController(),
                //child: ListviewInventoryMovement(listData: state),
              ),
              Toolbar(
                listData: [
                  ElementsBarModel(
                    text: null,
                    icon: const Icon(Icons.add),
                    action: () {
                      //context.read<ListviewInvMovCubit>().addRow();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
