import 'package:axol_inventarios/plugins/inventory/repository/warehouses_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/inventory_move_concept_model.dart';
import '../../../../models/textfield_model.dart';
import '../../../../models/user_mdoel.dart';
import '../../../../models/warehouse_model.dart';
import '../../../inventory/repository/inventory_concepts_repo.dart';
import '../../../user/repository/user_repo.dart';
import '../../model/movement_filter_model.dart';
import 'movement_filters_state.dart';

class MovementFiltersCubit extends Cubit<MovementFiltersState> {
  MovementFiltersCubit() : super(InitialState());

  void changeWarehouse(
      MovementFilterModel currentFilter, WarehouseModel? warehouse) {
    try {
      MovementFilterModel movementFilter;
      emit(LoadingState());
      movementFilter = MovementFilterModel(
          date: currentFilter.date,
          warehouse: warehouse,
          warehousesList: currentFilter.warehousesList,
          concept: currentFilter.concept,
          conceptsList: currentFilter.conceptsList,
          user: currentFilter.user,
          usersList: currentFilter.usersList,
          currentLimit: currentFilter.currentLimit);
      emit(LoadedState(movementFilters: movementFilter));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> getInitialValues(MovementFilterModel currentFilter) async {
    List<WarehouseModel> warehouses;
    List<InventoryMoveConceptModel> concepts;
    List<UserModel> users;
    MovementFilterModel movementFilter;
    final WarehouseModel warehouse;
    final Map<int, DateTime> date;
    final InventoryMoveConceptModel concept;
    final UserModel user;
    final TextfieldModel limit;

    emit(LoadingState());
    warehouses = await WarehousesRepo().fetchAllWarehouses();
    if (warehouses.last.id != 'all') {
      warehouses
          .add(WarehouseModel(id: 'all', name: 'TODOS', retailManager: ''));
    }
    concepts = await InventoryConceptsRepo().fetchAllConcepts();
    if (concepts.last.id != -1) {
      concepts
          .add(InventoryMoveConceptModel(concept: 'TODOS', id: -1, type: -1));
    }
    users = await DatabaseUser().fetchAllUsers();
    if (users.last.uid != 'all') {
      users
          .add(UserModel(name: 'TODOS', uid: 'all', rol: '//', password: '//'));
    }
    if (currentFilter.warehouse == null) {
      warehouse = WarehouseModel(id: 'all', name: 'TODOS', retailManager: '');
    } else {
      warehouse = currentFilter.warehouse!;
    }
    if (currentFilter.date == null) {
      date = {0: DateTime(0), 1: DateTime(3000)};
    } else {
      date = currentFilter.date!;
    }
    if (currentFilter.concept == null) {
      concept = InventoryMoveConceptModel(concept: 'TODOS', id: -1, type: -1);
    } else {
      concept = currentFilter.concept!;
    }
    if (currentFilter.user == null) {
      user = UserModel(name: 'TODOS', uid: 'all', rol: '//', password: '//');
    } else {
      user = currentFilter.user!;
    }
    if (currentFilter.currentLimit == null) {
      limit = TextfieldModel(text: '50', position: 0);
    } else {
      limit = currentFilter.currentLimit!;
    }
    movementFilter = MovementFilterModel(
        warehousesList: warehouses,
        warehouse: warehouse,
        date: date,
        concept: concept,
        conceptsList: concepts,
        user: user,
        usersList: users,
        currentLimit: limit);
    emit(LoadedState(movementFilters: movementFilter));
  }

  void changeDate(
      MovementFilterModel currentFilter, Map<int, DateTime> dateTime) async {
    MovementFilterModel movementFilter;
    emit(InitialState());
    movementFilter = MovementFilterModel(
        warehousesList: currentFilter.warehousesList,
        warehouse: currentFilter.warehouse,
        date: dateTime,
        concept: currentFilter.concept,
        conceptsList: currentFilter.conceptsList,
        user: currentFilter.user,
        usersList: currentFilter.usersList,
        currentLimit: currentFilter.currentLimit);
    emit(LoadedState(movementFilters: movementFilter));
  }

  void changeConcept(
      MovementFilterModel currentFilter, InventoryMoveConceptModel? concept) {
    try {
      MovementFilterModel movementFilter;
      emit(LoadingState());
      movementFilter = MovementFilterModel(
        date: currentFilter.date,
        warehouse: currentFilter.warehouse,
        warehousesList: currentFilter.warehousesList,
        concept: concept,
        conceptsList: currentFilter.conceptsList,
        user: currentFilter.user,
        usersList: currentFilter.usersList,
        currentLimit: currentFilter.currentLimit,
      );
      emit(LoadedState(movementFilters: movementFilter));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  void changeUser(MovementFilterModel currentFilter, UserModel? user) {
    try {
      MovementFilterModel movementFilter;
      emit(LoadingState());
      movementFilter = MovementFilterModel(
        date: currentFilter.date,
        warehouse: currentFilter.warehouse,
        warehousesList: currentFilter.warehousesList,
        concept: currentFilter.concept,
        conceptsList: currentFilter.conceptsList,
        user: user,
        usersList: currentFilter.usersList,
        currentLimit: currentFilter.currentLimit,
      );
      emit(LoadedState(movementFilters: movementFilter));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  void changeLimit(MovementFilterModel currentFilter, int limit, int position) {
    try {
      TextfieldModel currentLimit =
          TextfieldModel(text: limit.toString(), position: position);
      //Map<String, int> currentLimit = {'limit': limit, 'position': position};
      MovementFilterModel movementFilter;
      emit(LoadingState());
      movementFilter = MovementFilterModel(
        date: currentFilter.date,
        warehouse: currentFilter.warehouse,
        warehousesList: currentFilter.warehousesList,
        concept: currentFilter.concept,
        conceptsList: currentFilter.conceptsList,
        user: currentFilter.user,
        usersList: currentFilter.usersList,
        currentLimit: currentLimit,
      );
      emit(LoadedState(movementFilters: movementFilter));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
