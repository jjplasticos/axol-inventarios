import '../../../../models/inventory_move_concept_model.dart';
import '../../../../models/textfield_model.dart';
import '../../../../models/user_mdoel.dart';
import '../../inventory/model/warehouse_model.dart';

class MovementFilterModel {
  final WarehouseModel warehouse;
  final Map<int, DateTime> date;
  final List<WarehouseModel> warehousesList;
  final InventoryMoveConceptModel concept;
  final List<InventoryMoveConceptModel> conceptsList;
  final UserModel user;
  final List<UserModel> usersList;
  final TextfieldModel currentLimit;
  static const WarehouseModel initWarehouse =
      WarehouseModel(id: -1, name: 'TODOS', retailManager: '');
  static final Map<int, DateTime> initDate = {
    0: DateTime(0),
    1: DateTime(3000)
  };
  static const List<WarehouseModel> initWarehouseList = [];
  static const InventoryMoveConceptModel initConcept =
      InventoryMoveConceptModel(concept: 'TODOS', id: -1, type: -1);
  static const List<InventoryMoveConceptModel> initConceptList = [];
  static const UserModel initUser =
      UserModel(name: 'TODOS', uid: 'all', rol: '//', password: '//');
  static const List<UserModel> initUsersList = [];
  static TextfieldModel initLimit = TextfieldModel(text: '50', position: 0);

  const MovementFilterModel({
    required this.date,
    required this.warehouse,
    required this.warehousesList,
    required this.concept,
    required this.conceptsList,
    required this.user,
    required this.usersList,
    required this.currentLimit,
  });

  static MovementFilterModel initialValue() {
    return MovementFilterModel(
        date: initDate,
        warehouse: initWarehouse,
        warehousesList: initWarehouseList,
        concept: initConcept,
        conceptsList: initConceptList,
        user: initUser,
        usersList: initUsersList,
        currentLimit: initLimit);
  }
}
