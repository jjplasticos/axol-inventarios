import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/inventory_move_elements_model.dart';
import '../../../../../models/movement_transfer_model.dart';
import '../../../../../settings/theme.dart';
import '../../../cubit/inventory_load/inventory_load_cubit.dart';
import '../../../cubit/inventory_movements/inventory_moves_cubit.dart';
import '../../../cubit/show_details_product_stock/showdetails_productstock_cubit.dart';
import '../../../cubit/transfer_cubit.dart';
import '../../../cubit/textfield_finder_invrow_cubit.dart';
import '../../controllers/opendetails_productstock_controller.dart';
import 'dialog_serch_product.dart';

class ListviewInventoryMovement extends StatelessWidget {
  final InventoryMoveElementsModel elementsData;
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
                width: 400,
                child: BlocBuilder<TransferCubit, MovementTransferModel>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        DropdownButton<String>(
                          value: elementsData.concepts
                                  .map((element) {
                                    return element.concept;
                                  })
                                  .toList()
                                  .contains(elementsData.concept)
                              ? elementsData.concept
                              : null,
                          items: elementsData.concepts.map((element) {
                            return DropdownMenuItem(
                                value: element.concept,
                                child: Text(element.concept));
                          }).toList(),
                          onChanged: (value) {
                            context
                                .read<InventoryMovesCubit>()
                                .selectConcept(value.toString(), elementsData);
                            if (value == 'Salida por traspaso') {
                              context.read<TransferCubit>().change(
                                  true, inventoryName, state.inventory2, 1);
                            } else {
                              context
                                  .read<TransferCubit>()
                                  .change(false, '', '', 0);
                            }
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Visibility(
                            visible: context
                                .read<TransferCubit>()
                                .state
                                .inventories
                                .isNotEmpty,
                            child: DropdownButton(
                              value: state.inventories
                                      .map((e) {
                                        return e;
                                      })
                                      .toList()
                                      .contains(state.inventory2)
                                  ? state.inventory2
                                  : null,
                              items: state.inventories.map((e) {
                                return DropdownMenuItem(
                                    value: e, child: Text(e));
                              }).toList(),
                              onChanged: (value) {
                                context.read<TransferCubit>().change(true,
                                    state.inventory1, value!, state.concept);
                                context
                                    .read<InventoryMovesCubit>()
                                    .invTransfer(elementsData, value);
                              },
                            ))
                      ],
                    );
                  },
                ),
              ),
              Container(
                color: Colors.white30,
                height: 30,
                width: 200,
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'Documento',
                  ),
                  onChanged: (value) {
                    context
                        .read<InventoryMovesCubit>()
                        .editDocument(value, elementsData);
                  },
                ),
              ),
              Container(
                height: 30,
                width: 200,
                color: Colors.white30,
                child: Center(
                    child: Text(
                        '${elementsData.date.day}/${elementsData.date.month}/${elementsData.date.year}')),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                'Clave',
                style: Typo.labelText1,
              )),
            ),
            Expanded(
              flex: 2,
              child: Center(
                  child: Text(
                'Descripción',
                style: Typo.labelText1,
              )),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                'Cantidad',
                style: Typo.labelText1,
              )),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                'Peso unitario',
                style: Typo.labelText1,
              )),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                'Peso total',
                style: Typo.labelText1,
              )),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                '',
                style: Typo.labelText1,
              )),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: elementsData.products.length,
          itemBuilder: ((context, index) {
            TextEditingController txtCode = TextEditingController();
            final elementList = elementsData.products[index];
            return Container(
              height: 30,
              width: double.infinity,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black45)),
              child: Row(
                //1) Clave
                children: [
                  Expanded(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: txtCode
                                ..text = elementList.code.toString()
                                ..selection = TextSelection.collapsed(
                                    offset: elementList.code.toString().length),
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(isDense: true),
                              onSubmitted: (value) {
                                context.read<InventoryMovesCubit>().editCode(
                                    index, value, inventoryName, elementsData);
                              },
                              style: Typo.labelText1,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            height: 30,
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                    child: MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                            create: (_) =>
                                                InventoryLoadCubit()),
                                        BlocProvider(
                                            create: (_) =>
                                                TextfieldFinderInvrowCubit()),
                                      ],
                                      child: DialogSearchProduct(
                                          inventoryName: inventoryName),
                                    ),
                                  ),
                                ).then((value) {
                                  context.read<InventoryMovesCubit>().editCode(
                                      index,
                                      value,
                                      inventoryName,
                                      elementsData);
                                  txtCode.text = value.toString();
                                });
                              },
                              icon: const Icon(
                                Icons.search,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  //2) Descripcion
                  Expanded(
                    flex: 2,
                    child: Center(
                        child: elementList.description != ''
                            ? TextButton(
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        BlocProvider(
                                          create: (_) =>
                                              ShowDetailsProductStockCubit(),
                                          child:
                                              OpenDetailsProductStockController(
                                            code: elementList.code,
                                            inventoryName: inventoryName,
                                          ),
                                        )),
                                child: Text(elementList.description,
                                    style: Typo.labelText1),
                              )
                            : const Text('')),
                  ),
                  //3) Cantidad
                  Expanded(
                    flex: 1,
                    child: TextField(
                      onSubmitted: (value) {
                        context.read<InventoryMovesCubit>().editQuantity(
                            index, value, inventoryName, elementsData);
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
                  //4) Peso unitario
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      elementList.weightUnit.toString(),
                      style: Typo.labelText1,
                    )),
                  ),
                  //5) Pesto total
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        elementList.weightTotal.toStringAsFixed(2),
                        style: Typo.labelText1,
                      ),
                    ),
                  ),
                  //6) Eliminar fila
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          context
                              .read<InventoryMovesCubit>()
                              .removeRow(elementsData, index);
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 15,
                          color: Colors.white,
                        ),
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
