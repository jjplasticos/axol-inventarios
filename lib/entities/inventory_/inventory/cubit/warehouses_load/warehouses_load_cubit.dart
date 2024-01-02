import 'package:axol_inventarios/entities/inventory_/inventory/model/warehouse_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/user_mdoel.dart';
import '../../../../user/repository/user_repo.dart';
import '../../repository/warehouses_repo.dart';
import 'wareshouses_load_state.dart';

class WarehousesLoadCubit extends Cubit<WarehousesLoadState> {
  WarehousesLoadCubit() : super(InitialState());

  Future<void> loadWarehouses(int mode) async {
    try {
      emit(InitialState());
      emit(LoadingState());
      final List<WarehouseModel> warehouses =
          await WarehousesRepo().fetchAllWarehouses();
      final List<UserModel> users = await DatabaseUser().fetchAllUsers();
      emit(LoadedState(users: users, warehouses: warehouses, mode: mode));
    } catch (e) {
      emit(ErrorState(error: 'Error en WarehousesLoadCubit: ${e.toString()}'));
    }
  }

  Future<void> reload(
      int mode, List<UserModel> users, List<WarehouseModel> warehouses) async {
    emit(LoadingState());
    emit(LoadedState(users: users, warehouses: warehouses, mode: mode));
  }

  Future<void> remove(int id) async {
    try {
      emit(InitialState());
      emit(LoadingState());
      await WarehousesRepo().deleteWarehouse(id);
      final List<UserModel> users = await DatabaseUser().fetchAllUsers();
      final List<WarehouseModel> warehouses =
          await WarehousesRepo().fetchAllWarehouses();
      emit(LoadedState(mode: 0, users: users, warehouses: warehouses));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
