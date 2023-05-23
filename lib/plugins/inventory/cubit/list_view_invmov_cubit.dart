import 'package:axol_inventarios/plugins/inventory/repository/inventory_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/inventory_move_concept_model.dart';
import '../../../models/inventory_move_elements_model.dart';
import '../../../models/inventory_move_row_model.dart';
import '../repository/inventory_concepts_repo.dart';
import '../repository/product_repo.dart';

class ListviewInvMovCubit extends Cubit<InventoryMovetElementsModel> {
  final InventoryMoveRowModel emptyRow = const InventoryMoveRowModel(
      code: '',
      concept: '',
      description: '',
      quantity: '0',
      weightTotal: 0,
      weightUnit: 0,
      stockExist: false);
  static final DateTime _time = DateTime.now();
  final InventoryMovetElementsModel emptyElements = InventoryMovetElementsModel(
      products: [],
      concept: 'Concept',
      date: '${_time.day}/${_time.month}/${_time.year}',
      document: '',
      concepts: []);

  ListviewInvMovCubit()
      : super(const InventoryMovetElementsModel(
            products: [], concept: '', date: '', document: '', concepts: []));

  void initialState() {
    emit(emptyElements);
    InventoryMovetElementsModel elements;
    List<InventoryMoveRowModel> list = [];
    list.add(emptyRow);
    elements = InventoryMovetElementsModel(
      products: list,
      concept: state.concept,
      date: state.date,
      document: state.document,
      concepts: state.concepts,
    );
    emit(elements);
    showConcepts();
    emit(elements);
  }

  void addRow() {
    InventoryMovetElementsModel elements;
    List<InventoryMoveRowModel> list = state.products;
    emit(emptyElements);
    list.add(emptyRow);
    elements = InventoryMovetElementsModel(
      products: list,
      concept: state.concept,
      date: state.date,
      document: state.document,
      concepts: state.concepts,
    );
    emit(elements);
  }

  void removeRow(int i) {
    //state.removeAt(i);
    emit(state);
  }

  Future<void> editCode(int i, String currentCode, String inventoryName) async {
    List<InventoryMoveRowModel> list = state.products;
    InventoryMovetElementsModel elements;
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
    elements = InventoryMovetElementsModel(
      products: list,
      concept: state.concept,
      date: state.date,
      document: state.document,
      concepts: state.concepts,
    );
    emit(emptyElements);
    emit(elements);
  }

  Future<void> editQuantity(
      int i, String currentQuantity, String inventoryName) async {
    List<InventoryMoveRowModel> list = state.products;
    InventoryMovetElementsModel elements;
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
    elements = InventoryMovetElementsModel(
      products: list,
      concept: state.concept,
      date: state.date,
      document: state.document,
      concepts: state.concepts,
    );
    emit(emptyElements);
    emit(elements);
  }

  Future<void> showConcepts() async {
    //Muestra los conceptos de inventario guardado en la base de datos.
    List<String> concepts = [];
    List<InventoryMoveConceptModel> conceptsDB;
    InventoryMovetElementsModel elements;

    conceptsDB = await InventoryConceptsRepo().fetchAllConcepts();
    for (var element in conceptsDB) {
      concepts.add(element.concept.toString());
    }
    elements = InventoryMovetElementsModel(
      products: state.products,
      concept: state.concept,
      date: state.date,
      document: state.document,
      concepts: concepts,
    );
    emit(emptyElements);
    emit(elements);
  }

  Future<void> selectConcept(String concept) async {
    InventoryMovetElementsModel elements;

    elements = InventoryMovetElementsModel(
      products: state.products,
      concept: concept,
      date: state.date,
      document: state.document,
      concepts: state.concepts,
    );
    emit(emptyElements);
    emit(elements);
  }
}
