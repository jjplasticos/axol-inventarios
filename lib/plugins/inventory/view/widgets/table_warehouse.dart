import 'package:flutter/material.dart';

import '../../../../models/inventory_row_model.dart';
import '../../../../settings/theme.dart';

class TableWarehouse extends StatelessWidget {
  final List<InventoryRowModel> listData;

  const TableWarehouse({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    final ScrollController horizontalScrollController = ScrollController();

    const List<String> propertyList = [
      'code#code',
      'description',
      'packing',
      'capacity',
      'measure',
      'gauge',
      'pices',
      'weight',
      'stock#stock',
    ];
    List<DataColumn> columns = [];
    List<DataRow> rows = [];
    DataRow dataRow;
    List<DataCell> cells = [];
    DataCell dataCell;

    //Crea lista de columnas
    for (var element in propertyList) {
      if (element.contains('#')) {
        columns.add(DataColumn(
            label: Text(element.split('#').first, style: Typo.bodyText5)));
      } else {
        columns.add(DataColumn(label: Text(element, style: Typo.bodyText5)));
      }
    }

    //Crea lista de filas
    for (var element0 in listData) {
      //Crea una fila de celdas.
      for (var element1 in propertyList) {
        final String elementDecoded;
        if (element1.contains('#')) {
          elementDecoded = '#${element1.split('#').last}';
        } else {
          elementDecoded = element1;
        }
        if (elementDecoded == '#code') {
          dataCell = DataCell(Text(element0.code, style: Typo.bodyText6));
          cells.add(dataCell);
        } else if (elementDecoded == '#stock') {
          dataCell = DataCell(Text(element0.code, style: Typo.bodyText6));
          cells.add(dataCell);
        } else {
          if (element0.properties.containsKey(elementDecoded)) {
            dataCell = DataCell(Text(element0.properties[elementDecoded],
                style: Typo.bodyText6));
            cells.add(dataCell);
          }
        }
        //print(cells);
      }
      //Agrega 'dataRow' con 'cells' en 'rows'.
      dataRow = DataRow(cells: cells);
      rows.add(dataRow);
      //print(cells.length);
      //print(columns.length);
      cells.clear();
    }
    print(rows.elementAt(0).cells.length);
    print(rows.elementAt(1).cells.length);
    return Scrollbar(
        thumbVisibility: true,
        controller: horizontalScrollController,
        child: SingleChildScrollView(
            controller: horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: columns,
              rows: rows,
            )));
  }
}
