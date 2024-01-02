import 'package:axol_inventarios/entities/inventory_/inventory/model/inventory_move/inventory_move_row_model.dart';
import 'package:uuid/uuid.dart';

import '../../inventory/model/inventory_move/inventory_move_model.dart';

class MovementModel {
  final String id;
  final DateTime time;
  final String code;
  final String description;
  final String document;
  final String warehouse;
  final int concept;
  final int conceptType;
  final double quantity;
  final String user;
  final double stock;

  MovementModel({
    required this.id,
    required this.code,
    required this.concept,
    required this.conceptType,
    required this.description,
    required this.document,
    required this.quantity,
    required this.time,
    required this.warehouse,
    required this.user,
    required this.stock,
  });

  MovementModel.fromRowOfDoc(InventoryMoveModel doc, InventoryMoveRowModel row,
      String warehouseName, String userName, double newStock)
      : id = const Uuid().v4(),
        code = row.code,
        concept = doc.concept.id,
        conceptType = doc.concept.type,
        description = row.description,
        document = doc.document,
        quantity = row.quantity,
        time = DateTime.now(),
        warehouse = warehouseName,
        user = userName,
        stock = newStock;

  MovementModel.transferDestiny(InventoryMoveModel doc, InventoryMoveRowModel row,
      String warehouseDestiny, String userName, double newStock)
      : id = const Uuid().v4(),
        code = row.code,
        concept = 7,
        conceptType = 0,
        description = row.description,
        document = doc.document,
        quantity = row.quantity,
        time = DateTime.now(),
        warehouse = warehouseDestiny,
        user = userName,
        stock = newStock;
}
