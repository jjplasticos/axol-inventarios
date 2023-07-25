import 'package:flutter/material.dart';

import '../../../../models/inventory_row_model.dart';

class DialogProductInfo extends StatelessWidget {
  final InventoryRowModel inventoryRow;

  const DialogProductInfo({super.key, required this.inventoryRow});

  @override
  Widget build(BuildContext context) {
    const String code_ = 'code';
    const String type_ = 'type';
    const String gauge_ = 'gauge';
    const String pieces_ = 'pices';
    const String weight_ = 'weight';
    const String measure_ = 'measure';
    const String packing_ = 'packing';
    const String capacity_ = 'capacity';
    const String descriptrion_ = 'description';
    return Dialog(
      child: SizedBox(
        width: 400,
        height: 200,
        child: Padding(
            padding: const EdgeInsetsDirectional.all(4),
            child: Column(
              children: [
                Expanded(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Clave: '),
                        Text(inventoryRow.product.properties[code_].toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Tipo: '),
                        Text(inventoryRow.product.properties[type_].toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Calibre: '),
                        Text(inventoryRow.product.properties[gauge_].toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Piezas: '),
                        Text(
                            inventoryRow.product.properties[pieces_].toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Peso: '),
                        Text('${inventoryRow.product.properties[weight_]} KG')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Medida: '),
                        Text(inventoryRow.product.properties[measure_]
                            .toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Empaque: '),
                        Text(inventoryRow.product.properties[packing_]
                            .toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Capacidad: '),
                        Text(
                            '${inventoryRow.product.properties[capacity_]} GAL')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Descripción: '),
                        Text(inventoryRow.product.properties[descriptrion_]
                            .toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Stock: '),
                        Text(inventoryRow.stock.toString())
                      ],
                    ),
                  ]),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cerrar'),
                )
              ],
            )),
      ),
    );
  }
}
