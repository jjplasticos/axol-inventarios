import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/inventory_move_concept_model.dart';
import '../../../../models/inventory_move_elements_model.dart';
import '../../../../models/inventory_move_row_model.dart';
import '../../../../models/movement_model.dart';
import '../../../movements/repository/movement_repo.dart';
import '../../repository/inventory_concepts_repo.dart';
import '../../repository/inventory_repo.dart';
import '../../repository/product_repo.dart';
import 'inventory_moves_state.dart';

class InventoryMovesCubit extends Cubit<InventoryMovesState> {
  static const InventoryMoveRowModel _emptyRow = InventoryMoveRowModel(
      code: '',
      concept: '',
      description: '',
      quantity: '0',
      weightTotal: 0,
      weightUnit: 0,
      stockExist: false);
  static final DateTime _time = DateTime.now();
  final InventoryMoveElementsModel _emptyElements = InventoryMoveElementsModel(
      products: [],
      concept: 'Concept',
      date: '${_time.day}/${_time.month}/${_time.year}',
      document: '',
      concepts: []);

  InventoryMovesCubit() : super(SaveInitialState());

  void initialState() {
    emit(EditInitialState());
    InventoryMoveElementsModel elements;
    List<InventoryMoveRowModel> list = [];
    list.add(_emptyRow);
    elements = InventoryMoveElementsModel(
      products: list,
      concept: _emptyElements.concept,
      date: _emptyElements.date,
      document: _emptyElements.document,
      concepts: _emptyElements.concepts,
    );
    emit(EditState(inventoryMoveElements: elements));
    showConcepts(elements);
    emit(EditState(inventoryMoveElements: elements));
  }

  void addRow(InventoryMoveElementsModel current) {
    InventoryMoveElementsModel elements;
    List<InventoryMoveRowModel> list = current.products;
    emit(EditInitialState());
    list.add(_emptyRow);
    elements = InventoryMoveElementsModel(
      products: list,
      concept: current.concept,
      date: current.date,
      document: current.document,
      concepts: current.concepts,
    );
    emit(EditState(inventoryMoveElements: elements));
  }

  void removeRow(int i) {
    //state.removeAt(i);
    emit(state);
  }

  Future<void> editCode(int i, String currentCode, String inventoryName,
      InventoryMoveElementsModel current) async {
    List<InventoryMoveRowModel> list = current.products;
    InventoryMoveElementsModel elements;
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
    //Valida si hay stock suficiente.
    if (productStock.isNotEmpty) {
      if (quantity > double.parse(productStock['stock'].toString())) {
        stockExist = true;
      } else {
        stockExist = false;
      }
    }
    //Sí el producto existe, lo agrega a la lista de movimientos que está por
    // emitir.
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
    } else {
      total = quantity * 0;
      product = InventoryMoveRowModel(
          code: productDB['code'].toString(),
          description: '',
          quantity: quantity.toString(),
          weightUnit: 0,
          weightTotal: total,
          concept: list.elementAt(i).concept,
          stockExist: stockExist);
    }
    list[i] = product;
    elements = InventoryMoveElementsModel(
      products: list,
      concept: current.concept,
      date: current.date,
      document: current.document,
      concepts: current.concepts,
    );
    emit(EditInitialState());
    emit(EditState(inventoryMoveElements: elements));
  }

  Future<void> editQuantity(int i, String currentQuantity, String inventoryName,
      InventoryMoveElementsModel current) async {
    List<InventoryMoveRowModel> list = current.products;
    InventoryMoveElementsModel elements;
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
    elements = InventoryMoveElementsModel(
      products: list,
      concept: current.concept,
      date: current.date,
      document: current.document,
      concepts: current.concepts,
    );
    emit(EditInitialState());
    emit(EditState(inventoryMoveElements: elements));
  }

  Future<void> showConcepts(InventoryMoveElementsModel current) async {
    //Muestra los conceptos de inventario guardado en la base de datos.
    List<String> concepts = [];
    List<InventoryMoveConceptModel> conceptsDB;
    InventoryMoveElementsModel elements;

    conceptsDB = await InventoryConceptsRepo().fetchAllConcepts();
    for (var element in conceptsDB) {
      concepts.add(element.concept.toString());
    }
    elements = InventoryMoveElementsModel(
      products: current.products,
      concept: current.concept,
      date: current.date,
      document: current.document,
      concepts: concepts,
    );
    emit(EditInitialState());
    emit(EditState(inventoryMoveElements: elements));
  }

  Future<void> selectConcept(
      String concept, InventoryMoveElementsModel current) async {
    InventoryMoveElementsModel elements;

    elements = InventoryMoveElementsModel(
      products: current.products,
      concept: concept,
      date: current.date,
      document: current.document,
      concepts: current.concepts,
    );
    emit(EditInitialState());
    emit(EditState(inventoryMoveElements: elements));
  }

  Future<void> saveMovements(
      List<MovementModel> movements, InventoryMoveElementsModel current) async {
    try {
      emit(SaveInitialState());
      emit(SaveLoadingState(inventoryMoveElements: current));
      await MovementRepo().insertMovemets(movements);
      emit(SaveLoadedState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
