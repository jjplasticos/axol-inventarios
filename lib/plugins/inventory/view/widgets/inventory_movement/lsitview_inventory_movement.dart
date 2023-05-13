import 'package:flutter/material.dart';

import '../../../../../settings/theme.dart';

class ListviewInventoryMovement extends StatelessWidget {
  final List<String> listData;

  const ListviewInventoryMovement({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Clave',
                    style: Typo.labelText1,
                  )),
            ),
            Expanded(
              flex: 4,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Descripción',
                    style: Typo.labelText1,
                  )),
            ),
            Expanded(
              flex: 2,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Cantidad',
                    style: Typo.labelText1,
                  )),
            ),
            Expanded(
              flex: 2,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Peso unitario',
                    style: Typo.labelText1,
                  )),
            ),
            Expanded(
              flex: 2,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Peso total',
                    style: Typo.labelText1,
                  )),
            ),
            Expanded(
              flex: 1,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Mov',
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
                  TextField(),
                  Text('', style: Typo.labelText1),
                  TextField(),
                  Text(
                    '',
                    style: Typo.labelText1,
                  ),
                  Text(
                    '',
                    style: Typo.labelText1,
                  ),
                  Text(
                    '',
                    style: Typo.labelText1,
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
