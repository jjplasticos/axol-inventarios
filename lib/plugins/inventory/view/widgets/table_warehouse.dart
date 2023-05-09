import 'package:flutter/material.dart';

import '../../../../settings/theme.dart';

class TableWarehouse extends StatelessWidget {
  final List<String> listData;

  const TableWarehouse({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    const String clave = 'Clave';
    const String descripcion = 'Descripción';
    const String empaque = 'Empaque';
    const String capacidad = 'Capacidad';
    const String medida = 'Medida';
    const String calibre = 'Calibre';
    const String pieza = 'Pieza';
    const String peso = 'Peso';
    const String stock = 'Stock';
    final ScrollController _horizontalScrollController = ScrollController();
    return Scrollbar(
        thumbVisibility: true,
        controller: _horizontalScrollController,
        child: SingleChildScrollView(
            controller: _horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: DataTable(columns: [
              DataColumn(label: Text(clave, style: Typo.bodyText5)),
              DataColumn(label: Text(descripcion, style: Typo.bodyText5)),
              DataColumn(label: Text(empaque, style: Typo.bodyText5)),
              DataColumn(label: Text(capacidad, style: Typo.bodyText5)),
              DataColumn(label: Text(medida, style: Typo.bodyText5)),
              DataColumn(label: Text(calibre, style: Typo.bodyText5)),
              DataColumn(label: Text(pieza, style: Typo.bodyText5)),
              DataColumn(label: Text(peso, style: Typo.bodyText5)),
              DataColumn(label: Text(stock, style: Typo.bodyText5)),
            ], rows: [])));
    /*Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(clave, style: Typo.bodyText5)),
                flex: clave.length,
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(descripcion, style: Typo.bodyText5)),
                flex: descripcion.length,
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(empaque, style: Typo.bodyText5)),
                flex: empaque.length,
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(capacidad, style: Typo.bodyText5)),
                flex: capacidad.length,
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(medida, style: Typo.bodyText5)),
                flex: medida.length,
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(calibre, style: Typo.bodyText5)),
                flex: calibre.length,
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(pieza, style: Typo.bodyText5)),
                flex: pieza.length,
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {}, child: Text(peso, style: Typo.bodyText5)),
                flex: peso.length,
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    child: Text(stock, style: Typo.bodyText5)),
                flex: stock.length,
              ),
            ],
          ),*/
  }
}
