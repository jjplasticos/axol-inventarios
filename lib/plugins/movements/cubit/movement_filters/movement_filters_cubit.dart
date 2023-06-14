import 'package:axol_inventarios/plugins/inventory/repository/warehouses_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/inventory_move_concept_model.dart';
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
    movementFilter = MovementFilterModel(
        warehousesList: warehouses,
        warehouse: warehouses.last,
        date: currentFilter.date,
        concept: concepts.last,
        conceptsList: concepts,
        user: users.last,
        usersList: users,
        currentLimit: {'limit': 50, 'position': 0});
    emit(LoadedState(movementFilters: movementFilter));
  }

  void changeDate(MovementFilterModel currentFilter, String? dateTime) async {
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
      Map<String, int> currentLimit = {};
      if (limit != -1 && position != -1) {
        currentLimit = {'limit': limit, 'position': position};
      }
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
