import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global_widgets/toolbar.dart';
import '../../../../../models/elemnets_bar_model.dart';
import '../../../../../models/inventory_move_elements_model.dart';
import '../../../../../models/inventory_move_row_model.dart';
import '../../../../../settings/theme.dart';
import '../../../cubit/list_view_invmov_cubit.dart';

class ListviewInventoryMovement extends StatelessWidget {
  //final List<InventoryMoveRowModel> listData;
  final InventoryMovetElementsModel elementsData;
  final String inventoryName;

  const ListviewInventoryMovement(
      {super.key, required this.elementsData, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.white30,
                height: 30,
                width: 200,
                child: Row(
                  children: [
                    const Text('Concepto', style: Typo.labelText1),
                    PopupMenuButton(
                        onOpened: () {},
                        itemBuilder: (context) => [
                              const PopupMenuItem(child: Text('Concepto 1')),
                              const PopupMenuItem(child: Text('Concepto 2')),
                              const PopupMenuItem(child: Text('Concepto 3')),
                            ])
                  ],
                ),
              ),
              Container(
                color: Colors.white30,
                height: 30,
                width: 200,
                child: const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Documento',
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 200,
                color: Colors.white30,
                child: const Center(child: Text('dd/mm/aaaa')),
              )
            ],
          ),
        ),
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
          itemCount: elementsData.products.length,
          itemBuilder: ((context, index) {
            final elementList = elementsData.products[index];
            return Container(
              height: 30,
              width: double.infinity,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black45)),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(isDense: true),
                      onChanged: (value) {
                        context
                            .read<ListviewInvMovCubit>()
                            .editCode(index, value, inventoryName);
                      },
                      style: Typo.labelText1,
                    ),
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
                            .editQuantity(index, value, inventoryName);
                      },
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isDense: true,
                        errorStyle: const TextStyle(height: 0.3),
                        errorText: elementList.stockExist
                            ? 'Stock insuficiente'
                            : null,
                        errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                      controller: TextEditingController()
                        ..text = elementList.quantity.toString()
                        ..selection = TextSelection.collapsed(
                            offset: elementList.quantity.toString().length),
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
