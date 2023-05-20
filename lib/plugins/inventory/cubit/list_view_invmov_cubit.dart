import 'package:axol_inventarios/plugins/inventory/repository/inventory_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/inventory_move_row_model.dart';
import '../repository/product_repo.dart';

class ListviewInvMovCubit extends Cubit<List<InventoryMoveRowModel>> {
  final InventoryMoveRowModel emptyRow = const InventoryMoveRowModel(
      code: '',
      concept: '',
      description: '',
      quantity: '0',
      weightTotal: 0,
      weightUnit: 0,
      stockExist: false);

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

  Future<void> editCode(int i, String currentCode, String inventoryName) async {
    List<InventoryMoveRowModel> list = state;
    Map<String, dynamic> productDB;
    Map<String, dynamic> productStock;
    InventoryMoveRowModel product;
    double weight;
    double total;
    double quantity;
    bool stockExist = false;
    //Buscar currentCode en la base de datos y obtener los datos ncesarios.
    quantity = double.parse(list.elementAt(i).quantity);
    productDB = await ProductRepo().fetchProduct(currentCode);
    productStock =
        await InventoryRepo().fetchRowByCode(currentCode, inventoryName);
    if (productStock.isNotEmpty) {
      if (quantity > double.parse(productStock['stock'].toString())) {
        stockExist = true;
      } else {
        stockExist = false;
      }
    }
    if (productDB.isNotEmpty) {
      weight = double.parse(productDB['attributes']['weight'].toString());
      total = weight * quantity;
      product = InventoryMoveRowModel(
          code: productDB['code'].toString(),
          description: productDB['attributes']['description'].toString(),
          quantity: quantity.toString(),
          weightUnit: weight,
          weightTotal: total,
          concept: list.elementAt(i).concept,
          stockExist: stockExist);
      list[i] = product;
    }
    emit([]);
    emit(list);
  }

  Future<void> editQuantity(
      int i, String currentQuantity, String inventoryName) async {
    List<InventoryMoveRowModel> list = state;
    InventoryMoveRowModel product;
    Map<String, dynamic> productDB;
    double weight;
    double total;
    double? quantity;
    String quantityTxt;
    bool stockExist = false;

    productDB = await InventoryRepo()
        .fetchRowByCode(list.elementAt(i).code, inventoryName);

    if (currentQuantity == '') {
      currentQuantity = '0';
    }
    quantity = double.tryParse(currentQuantity);
    weight = list.elementAt(i).weightUnit;
    if (quantity != null) {
      if (productDB.isNotEmpty) {
        if (quantity > double.parse(productDB['stock'].toString())) {
          stockExist = true;
        } else {
          stockExist = false;
        }
      }
      if (currentQuantity.endsWith('.')) {
        quantityTxt = currentQuantity;
      } else {
        quantityTxt = quantity.toString();
      }
      total = quantity * weight;
      product = InventoryMoveRowModel(
          code: list.elementAt(i).code,
          description: list.elementAt(i).description,
          quantity: quantityTxt,
          weightUnit: weight,
          weightTotal: total,
          concept: list.elementAt(i).concept,
          stockExist: stockExist);
      list[i] = product;
    }
    emit([]);
    emit(list);
  }
}
