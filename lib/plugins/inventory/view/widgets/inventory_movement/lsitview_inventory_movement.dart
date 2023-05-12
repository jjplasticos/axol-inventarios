import 'package:flutter/material.dart';

class ListviewInventoryMovement extends StatelessWidget {
  final List<String> listData;

  const ListviewInventoryMovement({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                children: [Text('')],
              ),
            );
          }),
        )
      ],
    );
  }
}
