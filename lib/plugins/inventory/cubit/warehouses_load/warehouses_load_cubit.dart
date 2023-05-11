import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/warehouses_repo.dart';
import 'wareshouses_load_state.dart';

class WarehousesLoadCubit extends Cubit<WarehousesLoadState> {
  WarehousesLoadCubit() : super(InitialState());

  Future<void> loadWarehouses() async {
    try {
      emit(InitialState());
      emit(LoadingState());
      final List<String> names = await WarehousesRepo().fetchNames();
      emit(LoadedState(names: names));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
