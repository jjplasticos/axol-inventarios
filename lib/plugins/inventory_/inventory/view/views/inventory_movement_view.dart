import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../../settings/theme.dart';
import '../../cubit/inventory_load/inventory_load_cubit.dart';
import '../../cubit/inventory_movements/inventory_moves_cubit.dart';
import '../../cubit/transfer_cubit.dart';
import '../../cubit/textfield_finder_invrow_cubit.dart';
import '../controllers/inventory_moves_controller.dart';

class InventoryMovementView extends StatelessWidget {
  final String inventoryName;

  const InventoryMovementView({super.key, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    final String title = 'Movimientos en almacén: $inventoryName';

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => InventoryMovesCubit()),
          BlocProvider(create: (_) => InventoryLoadCubit()),
          BlocProvider(create: (_) => TextfieldFinderInvrowCubit()),
          BlocProvider(create: (_) => TransferCubit()),
        ],
        child: Scaffold(
          backgroundColor: ColorPalette.primaryBackground,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBarGlobal(
              title: title,
              iconButton: null,
              iconActions: const [],
            ),
          ),
          body: InventoryMovesController(inventoryName: inventoryName),
        ));
  }
}
