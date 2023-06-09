import 'package:axol_inventarios/models/user_mdoel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/inventory_model.dart';
import '../../../../models/inventory_move_concept_model.dart';
import '../../../../models/inventory_move_elements_model.dart';
import '../../../../models/inventory_move_row_model.dart';
import '../../../movements/model/movement_model.dart';
import '../../../movements/repository/movement_repo.dart';
import '../../../user/repository/user_repo.dart';
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
    concepts: [],
    invTransfer: '',
  );

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
      invTransfer: _emptyElements.invTransfer,
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
      invTransfer: current.invTransfer,
    );
    emit(EditState(inventoryMoveElements: elements));
  }

  void removeRow(InventoryMoveElementsModel current, int index) {
    InventoryMoveElementsModel elements;
    List<InventoryMoveRowModel> list = current.products;
    list.removeAt(index);
    elements = InventoryMoveElementsModel(
      products: list,
      concept: current.concept,
      date: current.date,
      document: current.document,
      concepts: current.concepts,
      invTransfer: current.invTransfer,
    );
    emit(EditInitialState());
    emit(EditState(inventoryMoveElements: elements));
  }

  Future<void> editCode(int i, String currentCode, String inventoryName,
      InventoryMoveElementsModel current) async {
    List<InventoryMoveRowModel> list = current.products;
    InventoryMoveElementsModel elements;
    Map<String, dynamic> productDB;
    InventoryModel? productStock;
    InventoryMoveRowModel product;
    double weight;
    double total;
    double quantity;
    bool stockExist = false;
    //Buscar currentCode en la base de datos y obtiene los datos ncesarios.
    quantity = double.parse(list.elementAt(i).quantity);
    productDB = await ProductRepo().fetchProduct(currentCode);
    productStock =
        await InventoryRepo().fetchRowByCode(currentCode, inventoryName);
    //Valida si hay stock suficiente.
    if (productStock != null) {
      if (quantity > productStock.stock) {
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
          code: currentCode, //productDB['code'].toString(),
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
      invTransfer: current.invTransfer,
    );
    emit(EditInitialState());
    emit(EditState(inventoryMoveElements: elements));
  }

  Future<void> editQuantity(int i, String currentQuantity, String inventoryName,
      InventoryMoveElementsModel current) async {
    List<InventoryMoveRowModel> list = current.products;
    InventoryMoveElementsModel elements;
    InventoryMoveRowModel product;
    InventoryModel? productDB;
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
      if (productDB != null) {
        if (quantity > productDB.stock) {
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
      invTransfer: current.invTransfer,
    );
    emit(EditInitialState());
    emit(EditState(inventoryMoveElements: elements));
  }

  Future<void> showConcepts(InventoryMoveElementsModel current) async {
    //Muestra los conceptos de inventario guardado en la base de datos.
    //List<String> concepts = [];
    List<InventoryMoveConceptModel> conceptsDB;
    InventoryMoveElementsModel elements;

    conceptsDB = await InventoryConceptsRepo().fetchAllConcepts();
    /*for (var element in conceptsDB) {
      concepts.add(element.concept.toString());
    }*/
    elements = InventoryMoveElementsModel(
      products: current.products,
      concept: current.concept,
      date: current.date,
      document: current.document,
      concepts: conceptsDB,
      invTransfer: current.invTransfer,
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
      invTransfer: current.invTransfer,
    );
    emit(EditInitialState());
    emit(EditState(inventoryMoveElements: elements));
  }

  Future<void> editDocument(
      String document, InventoryMoveElementsModel current) async {
    InventoryMoveElementsModel elements;

    elements = InventoryMoveElementsModel(
      products: current.products,
      concept: current.concept,
      date: current.date,
      document: document,
      concepts: current.concepts,
      invTransfer: current.invTransfer,
    );
    emit(EditInitialState());
    emit(EditState(inventoryMoveElements: elements));
  }

  Future<void> saveMovements(
      InventoryMoveElementsModel current, String inventory1) async {
    try {
      InventoryMoveElementsModel currentRedux;
      List<InventoryMoveRowModel> productsRedux = [];
      MovementModel movement;
      List<MovementModel> movements = [];
      InventoryMoveConceptModel conceptModel;
      bool successValidatio = true;
      String errorMessage = '';
      int conceptType = -1;
      UserModel userModel;

      if (current.concepts
              .indexWhere((value) => value.concept == current.concept) <
          0) {
        successValidatio = false;
        errorMessage = 'Seleccione un concepto.';
      } else {
        conceptType = current.concepts
            .elementAt(current.concepts
                .indexWhere((value) => value.concept == current.concept))
            .type;
      }
      //Reduce la lista de productos eliminando las filas que no contengan
      // descripción y valida el estock.
      for (var element in current.products) {
        //si es concepto de salida...
        if (conceptType == 1) {
          if (element.stockExist == true) {
            successValidatio = false;
            errorMessage = 'La cantidad supera el stock disponible.';
          }
        }
        if (element.description != '' && double.parse(element.quantity) > 0) {
          productsRedux.add(element);
        }
      }
      if (productsRedux.isEmpty) {
        successValidatio = false;
        errorMessage =
            'Agrege al menos un producto a la lista con cantidad mayor a 0';
      }

      if (successValidatio == true) {
        currentRedux = InventoryMoveElementsModel(
            products: productsRedux,
            concept: current.concept,
            date: current.date,
            document: current.document,
            concepts: current.concepts,
            invTransfer: current.invTransfer);

        //Craa la lista de movimientos que agragara al historial, en base de
        // 'currentRedux'.
        conceptModel = currentRedux.concepts.elementAt(currentRedux.concepts
            .indexWhere((value) => value.concept == current.concept));
        userModel = await LocalUser().getLocalUser();
        for (var element in currentRedux.products) {
          movement = MovementModel(
            id: const Uuid().v4(),
            code: element.code,
            concept: conceptModel.id,
            conceptType: conceptModel.type,
            description: element.description,
            document: currentRedux.document,
            quantity: double.parse(element.quantity),
            time: currentRedux.date,
            warehouse: inventory1,
            user: userModel.name,
          );
          movements.add(movement);
          if (conceptModel.id == 58) {
            movement = MovementModel(
              id: const Uuid().v4(),
              code: element.code,
              concept: 7,
              conceptType: 0,
              description: element.description,
              document: currentRedux.document,
              quantity: double.parse(element.quantity),
              time: currentRedux.date,
              warehouse: currentRedux.invTransfer,
              user: userModel.name,
            );
            movements.add(movement);
          }
        }
        emit(SaveInitialState());
        emit(SaveLoadingState(inventoryMoveElements: current));
        await InventoryRepo().updateInventory(movements);
        await MovementRepo().insertMovemets(movements);
        final List<UserModel> users = await DatabaseUser().fetchAllUsers();
        emit(SaveLoadedState(users: users));
      } else {
        emit(SaveInitialState());
        emit(SaveErrorState(
            inventoryMoveElements: current, errorMessage: errorMessage));
      }
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> invTransfer(
      InventoryMoveElementsModel current, String inventory2) async {
    InventoryMoveElementsModel newElement = InventoryMoveElementsModel(
        products: current.products,
        concept: current.concept,
        date: current.date,
        document: current.document,
        concepts: current.concepts,
        invTransfer: inventory2);
    emit(EditInitialState());
    emit(EditState(inventoryMoveElements: newElement));
  }
}
