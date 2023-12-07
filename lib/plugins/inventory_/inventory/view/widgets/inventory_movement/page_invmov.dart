import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../global_widgets/toolbar.dart';
import '../../../../../../global_widgets/views_bar.dart';
import '../../../../../../models/elemnets_bar_model.dart';
import '../../../model/inventory_move/inventory_move_model.dart';
import '../../../cubit/inventory_movements/inventory_moves_cubit.dart';
import 'listview_inventory_movement.dart';

class PageInvMov extends StatelessWidget {
  final InventoryMoveModel inventoryMoveElements;
  final String inventoryName;

  const PageInvMov(
      {super.key,
      required this.inventoryName,
      required this.inventoryMoveElements});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  Navigator.pop(context);
                }),
          ],
        ),
        Expanded(
          child: ListviewInventoryMovement(
            inventoryName: inventoryName,
            elementsData: inventoryMoveElements,
          ),
        ),
        Toolbar(
          listData: [
            ElementsBarModel(
              text: null,
              icon: const Icon(Icons.add),
              action: () {
                context
                    .read<InventoryMovesCubit>()
                    .addRow(inventoryMoveElements);
              },
            ),
            ElementsBarModel(
              text: null,
              icon: const Icon(Icons.save),
              action: () {
                context
                    .read<InventoryMovesCubit>()
                    .saveMovements(inventoryMoveElements, inventoryName);
              },
            )
          ],
        ),
      ],
    );
  }
}
