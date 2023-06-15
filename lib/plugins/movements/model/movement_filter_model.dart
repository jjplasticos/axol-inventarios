import '../../../models/inventory_move_concept_model.dart';
import '../../../models/textfield_model.dart';
import '../../../models/user_mdoel.dart';
import '../../../models/warehouse_model.dart';

class MovementFilterModel {
  final WarehouseModel? warehouse;
  final Map<int, DateTime>? date;
  final List<WarehouseModel>? warehousesList;
  final InventoryMoveConceptModel? concept;
  final List<InventoryMoveConceptModel>? conceptsList;
  final UserModel? user;
  final List<UserModel>? usersList;
  final TextfieldModel? currentLimit;

  const MovementFilterModel({
    this.date,
    this.warehouse,
    this.warehousesList,
    this.concept,
    this.conceptsList,
    this.user,
    this.usersList,
    this.currentLimit,
  });
}
