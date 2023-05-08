import 'package:flutter/material.dart';

import '../../../../settings/theme.dart';

class TableWarehouse extends StatelessWidget {
  final List<String> listData;

  const TableWarehouse({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            OutlinedButton(
                onPressed: () {}, child: Text('Clave', style: Typo.bodyText5)),
            OutlinedButton(
                onPressed: () {},
                child: Text('Descripción', style: Typo.bodyText5)),
            OutlinedButton(
                onPressed: () {},
                child: Text('Empaque', style: Typo.bodyText5)),
            OutlinedButton(
                onPressed: () {},
                child: Text('Capacidad', style: Typo.bodyText5)),
            OutlinedButton(
                onPressed: () {}, child: Text('Medida', style: Typo.bodyText5)),
            OutlinedButton(
                onPressed: () {},
                child: Text('Calibre', style: Typo.bodyText5)),
            OutlinedButton(
                onPressed: () {}, child: Text('Piezas', style: Typo.bodyText5)),
            OutlinedButton(
                onPressed: () {}, child: Text('Peso', style: Typo.bodyText5)),
            OutlinedButton(
                onPressed: () {}, child: Text('Stock', style: Typo.bodyText5)),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: listData.length,
          itemBuilder: ((context, index) {
            final elementList = listData[index];
            return const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
              child: SizedBox(),
            );
          }),
        )
      ],
    );
  }
}
