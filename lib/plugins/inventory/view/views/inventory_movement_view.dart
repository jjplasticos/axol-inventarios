import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../settings/theme.dart';
import '../../cubit/list_view_invmov_cubit.dart';
import '../../cubit/inventory_movements/inventory_moves_cubit.dart';
import '../controllers/inventory_moves_controller.dart';

class InventoryMovementView extends StatelessWidget {
  final String inventoryName;

  const InventoryMovementView({super.key, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    const String title = 'Menú de almacenes';

    return MultiBlocProvider(
        providers: [
          //BlocProvider(create: (_) => ListviewInvMovCubit()),
          BlocProvider(create: (_) => InventoryMovesCubit()),
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
          body: InventoryMovesController(inventoryName: inventoryName),
        ));
  }
}
