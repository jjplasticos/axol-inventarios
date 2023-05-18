import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/inventory_move_row_model.dart';
import '../repository/product_repo.dart';

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

  Future<void> editCode(int i, String currentCode) async {
    List<InventoryMoveRowModel> list = state;
    Map<String, dynamic> productDB;
    InventoryMoveRowModel product;
    double weight;
    double total;
    double quantity;
    //Buscar currentCode en la base de datos y obtener los datos ncesarios.
    quantity = list.elementAt(i).quantity;
    productDB = await ProductRepo().fetchProduct(currentCode);
    if (productDB.isNotEmpty) {
      weight = double.parse(productDB['weight'].toString());
      total = weight * quantity;
      product = InventoryMoveRowModel(
          code: productDB['code'].toString(),
          description: productDB['description'].toString(),
          quantity: quantity,
          weightUnit: weight,
          weightTotal: total,
          concept: list.elementAt(i).concept);
      list[i] = product;
    }
    emit(list);
  }
}
