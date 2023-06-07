import 'package:axol_inventarios/models/warehouse_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_mdoel.dart';
import '../../../user/repository/user_repo.dart';
import '../../repository/warehouses_repo.dart';
import 'wareshouses_load_state.dart';

class WarehousesLoadCubit extends Cubit<WarehousesLoadState> {
  WarehousesLoadCubit() : super(InitialState());

  Future<void> loadWarehouses() async {
    try {
      emit(InitialState());
      emit(LoadingState());
      final List<WarehouseModel> warehouses =
          await WarehousesRepo().fetchAllWarehouses();
      final List<UserModel> users = await DatabaseUser().fetchAllUsers();
      emit(LoadedState(users: users, warehouses: warehouses));
    } catch (e) {
      emit(ErrorState(error: 'Error en WarehousesLoadCubit: ${e.toString()}'));
    }
  }
}
