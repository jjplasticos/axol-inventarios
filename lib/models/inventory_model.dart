import 'package:uuid/uuid.dart';

import '../plugins/inventory_/inventory/model/warehouse_model.dart';

class InventoryModel {
  final String id;
  final double stock;
  final String retailManager;
  final String name;
  final String code;

  const InventoryModel({
    required this.code,
    required this.id,
    required this.name,
    required this.retailManager,
    required this.stock,
  });

  InventoryModel.stockZero(String newCode, WarehouseModel warehouse)
      : code = newCode,
        id = const Uuid().v4(),
        name = warehouse.name,
        retailManager = warehouse.retailManager,
        stock = 0;
}
