import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/inventory_movements/inventory_moves_cubit.dart';
import '../../cubit/inventory_movements/inventory_moves_state.dart';
import '../views/warehouse_view.dart';
import 'listview_invmov_controller.dart';

class InventoryMovesController extends StatelessWidget {
  final String inventoryName;

  const InventoryMovesController({super.key, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InventoryMovesCubit, InventoryMovesState>(
      bloc: context.read<InventoryMovesCubit>()..initialState(),
      listener: (context, state) {
        if (state is SaveLoadedState) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WarehouseView(
                        warehouseName: inventoryName,
                      )));
        }
      },
      builder: (context, state) {
        if (state is EditState) {
          return ListviewInvMovController(
            inventoryName: inventoryName,
            inventoryMoveElements: state.inventoryMoveElements,
          );
        } else if (state is SaveLoadingState) {
          return Stack(
            children: [
              ListviewInvMovController(
                inventoryName: inventoryName,
                inventoryMoveElements: state.inventoryMoveElements,
              ),
              Opacity(
                opacity: 0.5,
                child: Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
