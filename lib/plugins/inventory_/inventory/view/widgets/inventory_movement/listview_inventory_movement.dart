import 'package:axol_inventarios/plugins/inventory_/inventory/cubit/inventory_movements/moves_form_cubit.dart';
import 'package:axol_inventarios/plugins/inventory_/inventory/model/inventory_move/inventory_move_row_model.dart';
import 'package:axol_inventarios/plugins/inventory_/inventory/model/warehouse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/inventory_move/inventory_move_model.dart';
import '../../../../../../models/movement_transfer_model.dart';
import '../../../../../../settings/theme.dart';
import '../../../cubit/inventory_load/inventory_load_cubit.dart';
import '../../../cubit/inventory_movements/inventory_moves_cubit.dart';
import '../../../cubit/show_details_product_stock/showdetails_productstock_cubit.dart';
import '../../../cubit/transfer_cubit.dart';
import '../../../cubit/textfield_finder_invrow_cubit.dart';
import '../../controllers/opendetails_productstock_controller.dart';
import 'dialog_serch_product.dart';
import 'package:shimmer/shimmer.dart';

typedef Inm = InventoryMoveModel;

class ListviewInventoryMovement extends StatelessWidget {
  final WarehouseModel warehouse;

  const ListviewInventoryMovement({super.key, required this.warehouse});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    InventoryMoveModel form = context.read<MovesFormCubit>().state;
    List<InventoryMoveRowModel> products = [];
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(
          width: screenWidth > 600 ? screenWidth - 230 : 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white30,
                height: 30,
                child: BlocBuilder<TransferCubit, MovementTransferModel>(
                  builder: (context, state) {
                    if (form.states[Inm.tConcepts] == Inm.sLoaded) {
                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        scrollDirection: Axis.horizontal,
                        children: [
                          DropdownButton<String>(
                            value: form.concepts
                                    .map((element) {
                                      return element.concept;
                                    })
                                    .toList()
                                    .contains(form.concept)
                                ? form.concept
                                : null,
                            items: form.concepts.map((element) {
                              return DropdownMenuItem(
                                  value: element.concept,
                                  child: Text(element.concept));
                            }).toList(),
                            onChanged: (value) {
                              context
                                  .read<MovesFormCubit>()
                                  .setConcept(value.toString());
                              form = context.read<MovesFormCubit>().state;
                              context.read<InventoryMovesCubit>().load(form);
                              if (value == 'Salida por traspaso') {
                                context.read<TransferCubit>().change(
                                    true, warehouse.name, state.inventory2, 1);
                              } else {
                                context
                                    .read<TransferCubit>()
                                    .change(false, '', '', 0);
                              }
                            },
                          ),
                          const SizedBox(width: 8),
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
                                      .invTransfer(form, value);
                                },
                              )),
                          const SizedBox(width: 8),
                          SizedBox(
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
                                    .editDocument(value, form);
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Center(
                              child: Text(
                                  '${form.date.day}/${form.date.month}/${form.date.year}')),
                        ],
                      );
                    } else {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.black26,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              width: 200,
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.black26,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              width: 200,
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.black26,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              width: 200,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: form.products.length,
                itemBuilder: ((context, index) {
                  TextEditingController txtCode = TextEditingController();
                  final moveRow = form.products[index];
                  return Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45)),
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
                                      ..text = moveRow.code.toString()
                                      ..selection = TextSelection.collapsed(
                                          offset:
                                              moveRow.code.toString().length),
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration:
                                        const InputDecoration(isDense: true),
                                    onSubmitted: (value) {
                                      context
                                          .read<InventoryMovesCubit>()
                                          .enterCode(
                                              index, form, value, warehouse);
                                    },
                                    onChanged: (value) {
                                      form.products[index].code = value;
                                      context
                                          .read<MovesFormCubit>()
                                          .setForm(form);
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
                                        builder: (BuildContext context) =>
                                            Dialog(
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
                                                inventoryName: warehouse.name),
                                          ),
                                        ),
                                      ).then((value) {
                                        context
                                            .read<InventoryMovesCubit>()
                                            .enterCode(
                                                index, form, value, warehouse);
                                        /*context
                                            .read<InventoryMovesCubit>()
                                            .editCode(index, value,
                                                warehouse, form);*/
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
                          child: Center(child: Builder(
                            builder: (context) { 
                              if (moveRow.states[moveRow.tDescription] ==
                                  moveRow.sLoading) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.white12,
                                  highlightColor: Colors.white24,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 4),
                                    width: 200,
                                  ),
                                );
                               } else if (moveRow.states[moveRow.tDescription] == moveRow.sLoaded) {
                                return TextButton(
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          BlocProvider(
                                            create: (_) =>
                                                ShowDetailsProductStockCubit(),
                                            child:
                                                OpenDetailsProductStockController(
                                              code: moveRow.code,
                                              inventoryName: warehouse.name,
                                            ),
                                          )),
                                  child: Text(moveRow.description,
                                      style: Typo.labelText1),
                                );
                              } else if (moveRow.states[moveRow.tDescription] == moveRow.sError) {
                                if (moveRow.states[moveRow.tErrorMessage] == moveRow.erNotProduct) {
                                  return const Text('Producto no existente',
                                    style: Typo.labelText1);
                                } else {
                                  return const Text('');
                                }
                              } else {
                                return const Text('');
                              }
                            },
                          )),
                        ),
                        //3) Cantidad
                        Expanded(
                          flex: 1,
                          child: TextField(
                            onSubmitted: (value) {
                              context.read<InventoryMovesCubit>().editQuantity(
                                  index, value, warehouse.name, form);
                            },
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              isDense: true,
                              errorStyle: const TextStyle(height: 0.3),
                              errorText: moveRow.stockExist
                                  ? 'Stock insuficiente'
                                  : null,
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                            ),
                            controller: TextEditingController()
                              ..text = moveRow.quantity.toString()
                              ..selection = TextSelection.collapsed(
                                  offset: moveRow.quantity.toString().length),
                            style: Typo.labelText1,
                          ),
                        ),
                        //4) Peso unitario
                        Expanded(
                          flex: 1,
                          child: Center(
                              child: Text(
                            moveRow.weightUnit.toString(),
                            style: Typo.labelText1,
                          )),
                        ),
                        //5) Pesto total
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              moveRow.weightTotal.toStringAsFixed(2),
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
                                products = form.products;
                                products.removeAt(index);
                                form.products = products;
                                context
                                    .read<MovesFormCubit>()
                                    .setProducts(products);
                                context.read<InventoryMovesCubit>().load(form);
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
              )),
            ],
          ),
        )
      ],
    );
  }
}
