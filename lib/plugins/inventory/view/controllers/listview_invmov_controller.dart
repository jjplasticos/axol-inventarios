import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/toolbar.dart';
import '../../../../global_widgets/views_bar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../models/inventory_move_elements_model.dart';
import '../../../../models/inventory_move_row_model.dart';
import '../../cubit/inventory_movements/inventory_moves_cubit.dart';
import '../../cubit/inventory_movements/inventory_moves_state.dart';
import '../../cubit/list_view_invmov_cubit.dart';
import '../widgets/inventory_movement/lsitview_inventory_movement.dart';

class ListviewInvMovController extends StatelessWidget {
  final InventoryMoveElementsModel inventoryMoveElements;
  final String inventoryName;

  const ListviewInvMovController(
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
              action: () {},
            )
          ],
        ),
      ],
    );
  }
}
