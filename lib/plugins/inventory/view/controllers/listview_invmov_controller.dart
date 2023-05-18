import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/toolbar.dart';
import '../../../../global_widgets/views_bar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../models/inventory_move_row_model.dart';
import '../../cubit/list_view_invmov_cubit.dart';
import '../widgets/inventory_movement/lsitview_inventory_movement.dart';

class ListviewInvMovController extends StatelessWidget {
  const ListviewInvMovController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListviewInvMovCubit, List<InventoryMoveRowModel>>(
      bloc: context.read<ListviewInvMovCubit>()..initialState(),
      builder: (context, state) {
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
              child: ListviewInventoryMovement(listData: state),
            ),
            Toolbar(
              listData: [
                ElementsBarModel(
                  text: null,
                  icon: const Icon(Icons.add),
                  action: () {
                    context.read<ListviewInvMovCubit>().addRow();
                  },
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
