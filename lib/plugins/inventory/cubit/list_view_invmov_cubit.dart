import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/inventory_move_row_model.dart';

class ListviewInvMovCubit extends Cubit<List<InventoryMoveRowModel>> {
  final InventoryMoveRowModel emptyRow = const InventoryMoveRowModel(
      code: '',
      concept: '',
      description: '',
      quantity: 0,
      weightTotal: 0,
      weightUnit: 0);

  ListviewInvMovCubit() : super([]);

  void initialState() {
    emit([]);
    List<InventoryMoveRowModel> list = state;
    list.add(emptyRow);
    emit(list);
  }

  void addRow() {
    List<InventoryMoveRowModel> list = state;
    emit([]);
    list.add(emptyRow);
    emit(list);
  }

  void removeRow(int i) {
    state.removeAt(i);
    emit(state);
  }
}
