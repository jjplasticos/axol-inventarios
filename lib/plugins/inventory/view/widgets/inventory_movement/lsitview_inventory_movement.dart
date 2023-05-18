import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global_widgets/toolbar.dart';
import '../../../../../models/elemnets_bar_model.dart';
import '../../../../../models/inventory_move_row_model.dart';
import '../../../../../settings/theme.dart';
import '../../../cubit/list_view_invmov_cubit.dart';

class ListviewInventoryMovement extends StatelessWidget {
  final List<InventoryMoveRowModel> listData;

  const ListviewInventoryMovement({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton(
                  onPressed: () {
                    context.read<ListviewInvMovCubit>().addRow();
                  },
                  child: const Text(
                    'Clave',
                    style: Typo.labelText1,
                  )),
            ),
            Expanded(
              flex: 2,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Descripción',
                    style: Typo.labelText1,
                  )),
            ),
            Expanded(
              flex: 1,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Cantidad',
                    style: Typo.labelText1,
                  )),
            ),
            Expanded(
              flex: 1,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Peso unitario',
                    style: Typo.labelText1,
                  )),
            ),
            Expanded(
              flex: 1,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Peso total',
                    style: Typo.labelText1,
                  )),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: listData.length,
          itemBuilder: ((context, index) {
            final elementList = listData[index];
            return Container(
              height: 30,
              width: double.infinity,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black45)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text('', style: Typo.labelText1),
                    flex: 2,
                  ),
                  Expanded(
                    child: TextField(),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(
                      '',
                      style: Typo.labelText1,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(
                      '',
                      style: Typo.labelText1,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(
                      '',
                      style: Typo.labelText1,
                    ),
                    flex: 1,
                  )
                ],
              ),
            );
          }),
        )
      ],
    );
  }
}
