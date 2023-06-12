import 'package:axol_inventarios/plugins/inventory/repository/warehouses_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/warehouse_model.dart';
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
      );
      emit(LoadedState(movementFilters: movementFilter));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> getWarehouses(MovementFilterModel currentFilter) async {
    List<WarehouseModel> warehouses;
    MovementFilterModel movementFilter;
    emit(LoadingState());
    warehouses = await WarehousesRepo().fetchAllWarehouses();
    movementFilter = MovementFilterModel(
      warehousesList: warehouses,
      warehouse: currentFilter.warehouse,
      date: currentFilter.date,
    );
    emit(LoadedState(movementFilters: movementFilter));
  }

  void changeDate(MovementFilterModel currentFilter, String? dateTime) async {
    MovementFilterModel movementFilter;
    emit(InitialState());
    movementFilter = MovementFilterModel(
      warehousesList: currentFilter.warehousesList,
      warehouse: currentFilter.warehouse,
      date: dateTime,
    );
    emit(LoadedState(movementFilters: movementFilter));
  }
}
