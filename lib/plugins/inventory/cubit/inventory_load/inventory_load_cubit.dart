import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/inventory_row_model.dart';
import '../../repository/inventory_repo.dart';
import 'inventory_load_state.dart';

class InventoryLoadCubit extends Cubit<InventoryLoadState> {
  InventoryLoadCubit() : super(InitialState());

  Future<void> loadInventory(String inventoryName) async {
    try {
      emit(InitialState());
      emit(LoadingState());
      final List<InventoryRowModel> inventoryList =
          await InventoryRepo().getInventoryList(inventoryName);
      emit(LoadedState(inventoryList: inventoryList));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
