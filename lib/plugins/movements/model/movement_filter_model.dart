import '../../../models/warehouse_model.dart';

class MovementFilterModel {
  final WarehouseModel? warehouse;
  final String? date;
  final List<WarehouseModel>? warehousesList;

  const MovementFilterModel({
    this.date,
    this.warehouse,
    this.warehousesList,
  });
}
