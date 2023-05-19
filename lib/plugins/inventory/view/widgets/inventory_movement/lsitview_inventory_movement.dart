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
    //final txtValue = context.watch<TextfieldFinderInvrowCubit>().state;
    /*final controller = TextEditingController()
      ..text = txtValue
      ..selection = TextSelection.collapsed(offset: txtValue.length);*/
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton(
                  onPressed: () {},
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
                    flex: 1,
                    child: Center(
                        child: TextField(
                      onChanged: (value) {
                        context
                            .read<ListviewInvMovCubit>()
                            .editCode(index, value);
                      },
                      style: Typo.labelText1,
                    )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                        child: Text(elementList.description,
                            style: Typo.labelText1)),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      onChanged: (value) {
                        context
                            .read<ListviewInvMovCubit>()
                            .editQuantity(index, value);
                      },
                      controller: TextEditingController()
                        ..text = elementList.quantity.toString()
                        ..selection = TextSelection.collapsed(
                            offset: elementList.quantity.toString().length),
                      /*TextEditingController(
                          text: elementList.quantity.toString()),*/
                      style: Typo.labelText1,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      elementList.weightUnit.toString(),
                      style: Typo.labelText1,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        elementList.weightTotal.toStringAsFixed(2),
                        style: Typo.labelText1,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        )
      ],
    );
  }
}
