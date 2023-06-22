import 'package:axol_inventarios/models/warehouse_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../repository/warehouses_repo.dart';
import 'warehouse_setting_state.dart';

class WarehouseSettingCubit extends Cubit<WarehouseSettingState> {
  WarehouseSettingCubit() : super(InitialState());

  Future<void> change(
      String? userSelected, String currentName, int txtPosition) async {
    try {
      emit(InitialState());
      emit(EditState(
          userSelected: userSelected,
          currentName: currentName,
          txtPosition: txtPosition));
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
      if (warehouseDB == null) {
        warehouse = WarehouseModel(
            id: const Uuid().v4(), name: name, retailManager: retailManager);
        await WarehousesRepo().insertWarehouse(warehouse);
        emit(LoadedState());
      } else {
        emit(EditState(
            userSelected: name,
            currentName: retailManager,
            error: true,
            message: 'El nombre de inventario ya existe',
            txtPosition: 0));
      }
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
      emit(RemoveLoadingState());
      await WarehousesRepo().deleteWarehouse(id);
      emit(RemoveLoadedState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> openAlert(String id) async {
    try {
      emit(InitialState());
      emit(RemoveAlertState(id: id));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
