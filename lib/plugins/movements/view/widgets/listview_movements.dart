import 'package:flutter/material.dart';

import '../../../../settings/theme.dart';
import '../../model/movement_model.dart';

class ListviewMovements extends StatelessWidget {
  final List<MovementModel> movementsList;

  const ListviewMovements({super.key, required this.movementsList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                'Almacén',
                style: Typo.labelText1,
              )),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                'Documento',
                style: Typo.labelText1,
              )),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                'Clave',
                style: Typo.labelText1,
              )),
            ),
            Expanded(
              flex: 1,
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
                'Concepto',
                style: Typo.labelText1,
              )),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                'Fecha',
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
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: movementsList.length,
          itemBuilder: (context, index) {
            final movement = movementsList[index];
            return Container(
              height: 30,
              width: double.infinity,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black45)),
              child: OutlinedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Expanded(
                      //1) Warehouse
                      flex: 1,
                      child: Center(
                        child: Text(
                          movement.warehouse,
                          style: Typo.labelText1,
                        ),
                      ),
                    ),
                    Expanded(
                      // 2) Document
                      flex: 1,
                      child: Center(
                        child: Text(
                          movement.document,
                          style: Typo.labelText1,
                        ),
                      ),
                    ),
                    Expanded(
                      // 3) Code
                      flex: 1,
                      child: Center(
                        child: Text(
                          movement.code,
                          style: Typo.labelText1,
                        ),
                      ),
                    ),
                    Expanded(
                      // 4) Description
                      flex: 1,
                      child: Center(
                        child: Text(
                          movement.description,
                          style: Typo.labelText1,
                        ),
                      ),
                    ),
                    Expanded(
                      // 5) Concept
                      flex: 1,
                      child: Center(
                        child: Text(
                          movement.concept.toString(),
                          style: Typo.labelText1,
                        ),
                      ),
                    ),
                    Expanded(
                      // 6) Date
                      flex: 1,
                      child: Center(
                        child: Text(
                          movement.time,
                          style: Typo.labelText1,
                        ),
                      ),
                    ),
                    Expanded(
                      // 7) Quantity
                      flex: 1,
                      child: Center(
                        child: Text(
                          movement.quantity.toString(),
                          style: Typo.labelText1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
