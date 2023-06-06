import 'package:axol_inventarios/models/warehouse_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/warehouses_repo.dart';
import 'warehouse_setting_state.dart';

class WarehouseSettingCubit extends Cubit<WarehouseSettingState> {
  WarehouseSettingCubit() : super(InitialState());

  Future<void> change(String? userSelected) async {
    try {
      emit(InitialState());
      emit(EditState(userSelected: userSelected));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> add(String name, String retailManager) async {
    try {
      WarehouseModel? warehouseDB;
      WarehouseModel warehouse;
      emit(InitialState());
      emit(LoadingState());
      warehouseDB = await WarehousesRepo().fetchWarehouse(name);
      if (warehouseDB != null) {
        warehouse = WarehouseModel(
            id: warehouseDB.id, name: name, retailManager: retailManager);
        await WarehousesRepo().insertWarehouse(warehouse);
      } else {
        if (kDebugMode) {
          print('warehouseDB == null');
        }
      }
      emit(LoadedState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> edit(WarehouseModel warehouse) async {
    try {
      emit(InitialState());
      emit(LoadingState());
      await WarehousesRepo().updateWarehouse(warehouse);
      emit(LoadedState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> remove(String id) async {
    try {
      emit(InitialState());
      emit(LoadingState());
      await WarehousesRepo().deleteWarehouse(id);
      emit(LoadedState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
