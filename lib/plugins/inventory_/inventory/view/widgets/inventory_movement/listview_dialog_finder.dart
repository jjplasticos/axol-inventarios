import 'package:flutter/material.dart';

import '../../../../../models/inventory_row_model.dart';

class ListviewDialogFinder extends StatelessWidget {
  final List<InventoryRowModel> listData;

  const ListviewDialogFinder({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, index) {
        final elementList = listData[index];
        return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
          width: double.infinity,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(elementList.product.code),
              Text(elementList.product.description),
              Text(elementList.stock.toString()),
              IconButton(
                onPressed: () {
                  Navigator.pop(context, elementList.product.code);
                },
                icon: const Icon(Icons.keyboard_arrow_right_outlined),
              ),
            ],
          ),
        );
      },
    ));
  }
}
