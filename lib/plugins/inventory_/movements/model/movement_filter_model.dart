import '../../inventory/model/inventory_move/concept_move_model.dart';
import '../../../../models/textfield_model.dart';
import '../../../../models/user_mdoel.dart';
import '../../inventory/model/warehouse_model.dart';

class MovementFilterModel {
  final WarehouseModel warehouse;
  final Map<int, DateTime> date;
  final List<WarehouseModel> warehousesList;
  final ConceptMoveModel concept;
  final List<ConceptMoveModel> conceptsList;
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
  static const ConceptMoveModel initConcept =
      ConceptMoveModel(text: 'TODOS', id: -1, type: -1);
  static const List<ConceptMoveModel> initConceptList = [];
  static const UserModel initUser =
      UserModel(name: 'TODOS', id: -1, rol: '//', password: '//');
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
