import 'package:flutter/material.dart';

import '../../../../../models/inventory_row_model.dart';
import '../../../../../settings/theme.dart';
import 'dialog_productinfo.dart';

class ListviewWarehouse extends StatelessWidget {
  final List<InventoryRowModel> listData;
  final String warehouseName;

  const ListviewWarehouse(
      {super.key, required this.listData, required this.warehouseName});

  @override
  Widget build(BuildContext context) {
    const String descriptrion_ = 'description';
    return Column(
      children: [
        Row(
          children: const [
            Text(
              'Almacén: ',
              style: Typo.bodyText5,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Clave',
              style: Typo.bodyText5,
            ),
            Text(
              'Descripción',
              style: Typo.bodyText5,
            ),
            Text(
              'Stock',
              style: Typo.bodyText5,
            ),
          ],
        ),
        ListView.builder(
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
                      Text(
                        elementList.code,
                        style: Typo.labelText1,
                      ),
                      Text(
                        elementList.properties[descriptrion_],
                        style: Typo.labelText1,
                      ),
                      Text(
                        elementList.stock.toString(),
                        style: Typo.labelText1,
                      )
                    ],
                  ),
                ));
          }),
        )
      ],
    );
  }
}
