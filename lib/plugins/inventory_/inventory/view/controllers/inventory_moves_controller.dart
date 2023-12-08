import 'package:axol_inventarios/plugins/inventory_/inventory/cubit/inventory_movements/moves_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../settings/theme.dart';
import '../../cubit/inventory_movements/inventory_moves_cubit.dart';
import '../../cubit/inventory_movements/inventory_moves_state.dart';
import '../../model/inventory_move/inventory_move_model.dart';
import '../views/warehouse_view.dart';
import '../widgets/inventory_movement/page_invmov.dart';

/*class InventoryMovesController extends StatelessWidget {
  final String inventoryName;

  const InventoryMovesController({super.key, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InventoryMovesCubit, InventoryMovesState>(
      bloc: context.read<InventoryMovesCubit>()..initLoad(),
      listener: (context, state) {
        if (state is SaveLoadedState) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WarehouseView(
                        warehouseName: inventoryName,
                        users: state.users,
                      )));
        } else if (state is SaveErrorState) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Alerta!'),
              content: Text(state.errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Aceptar'),
                )
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoadedState) {
          return PageInvMov(
            inventoryName: inventoryName,
            inventoryMoveElements: state.inventoryMoveElements,
          );
        } else if (state is SaveLoadingState) {
          return const LinearProgressIndicator();
        } else if (state is SaveErrorState) {
          return PageInvMov(
            inventoryName: inventoryName,
            inventoryMoveElements: state.inventoryMoveElements,
          );
        } else {
          return Text(
            'Estado recibido: $state',
            style: Typo.labelText1,
          );
        }
      },
    );
  }
}*/
