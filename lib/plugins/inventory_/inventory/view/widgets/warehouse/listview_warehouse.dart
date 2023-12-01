import 'package:flutter/material.dart';

import '../../../../../../models/inventory_row_model.dart';
import '../../../../../../settings/theme.dart';
import '../dialog_productinfo.dart';

class ListviewWarehouse extends StatelessWidget {
  final List<InventoryRowModel> listData;

  const ListviewWarehouse({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    const String descriptrion_ = 'description';
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
                child: Text(
              'Clave',
              style: Typo.bodyText5,
              textAlign: TextAlign.center,
            )),
            Expanded(
              flex: 1,
                child: Text(
              'Descripción',
              style: Typo.bodyText5,
              textAlign: TextAlign.center,
            )),
            Expanded(
              flex: 1,
                child: Text(
              'Stock',
              style: Typo.bodyText5,
              textAlign: TextAlign.center,
            )),
          ],
        ),
        Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: listData.length,
          itemBuilder: ((context, index) {
            final elementList = listData[index];
            return OutlinedButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        DialogProductInfo(inventoryRow: elementList)),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            elementList.product.code,
                            style: Typo.labelText1,
                            textAlign: TextAlign.center,
                          )),
                      Expanded(
                          flex: 1,
                          child: Text(
                            elementList.product.properties[descriptrion_],
                            style: Typo.labelText1,
                            textAlign: TextAlign.center,
                          )),
                      Expanded(
                          flex: 1,
                          child: Text(
                            elementList.stock.toString(),
                            style: Typo.labelText1,
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                ));
          }),
        ))
      ],
    );
  }
}
