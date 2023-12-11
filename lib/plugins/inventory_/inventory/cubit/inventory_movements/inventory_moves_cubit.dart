import 'package:axol_inventarios/models/inventory_row_model.dart';
import 'package:axol_inventarios/models/user_mdoel.dart';
import 'package:axol_inventarios/plugins/inventory_/inventory/cubit/inventory_movements/moves_form_cubit.dart';
import 'package:axol_inventarios/plugins/inventory_/inventory/model/warehouse_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../models/inventory_model.dart';
import '../../../product/model/product_model.dart';
import '../../model/inventory_move/inventory_move_concept_model.dart';
import '../../model/inventory_move/inventory_move_model.dart';
import '../../model/inventory_move/inventory_move_row_model.dart';
import '../../../movements/model/movement_model.dart';
import '../../../movements/repository/movement_repo.dart';
import '../../../../user/repository/user_repo.dart';
import '../../repository/inventory_concepts_repo.dart';
import '../../repository/inventory_repo.dart';
import '../../../product/repository/product_repo.dart';
import 'inventory_moves_state.dart';

class InventoryMovesCubit extends Cubit<InventoryMovesState> {
  InventoryMovesCubit() : super(SaveInitialState());

  Future<void> initLoad() async {
    emit(InitialState());
    InventoryMoveModel form = InventoryMoveModel.empty();
    List<InventoryMoveRowModel> list = [];

    form.states[InventoryMoveModel.tConcepts] = InventoryMoveModel.sLoading;
    list.add(InventoryMoveRowModel.empty());
    form.products = list;
    emit(LoadedState(form: form));
    form.concepts = await InventoryConceptsRepo().fetchAllConcepts();
    form.states[InventoryMoveModel.tConcepts] = InventoryMoveModel.sLoaded;
    emit(InitialState());
    emit(LoadedState(form: form));
  }

  void load(InventoryMoveModel form) {
    emit(InitialState());
    emit(LoadedState(form: form));
  }

  //Obsoleto
  /*void addRow(InventoryMoveModel current) {
    InventoryMoveModel elements;
    List<InventoryMoveRowModel> list = current.products;
    emit(InitialState());
    list.add(_emptyRow);
    elements = InventoryMoveModel(
      products: list,
      concept: current.concept,
      date: current.date,
      document: current.document,
      concepts: current.concepts,
      invTransfer: current.invTransfer,
    );
    emit(LoadedState(inventoryMoveElements: elements));
  }*/

  /*void removeRow(InventoryMoveModel current, int index) {
    InventoryMoveModel elements;
    List<InventoryMoveRowModel> list = current.products;
    list.removeAt(index);
    elements = InventoryMoveModel(
      products: list,
      concept: current.concept,
      date: current.date,
      document: current.document,
      concepts: current.concepts,
      invTransfer: current.invTransfer,
    );
    emit(InitialState());
    emit(LoadedState(inventoryMoveElements: elements));
  }*/

  Future<void> enterCode(int index, InventoryMoveModel form, String inputCode,
      WarehouseModel warehouse) async {
    emit(InitialState());
    final double quantity;
    final ProductModel? productDB;
    final InventoryModel? inventoryStock;
    final bool stockExist;
    InventoryMoveRowModel moveRow = InventoryMoveRowModel();
    InventoryMoveModel updateForm = form;

    moveRow.code = 'code';
    

    updateForm.products[index].states = {moveRow.tDescription:}
    //Buscar currentCode en la base de datos y obtiene los datos ncesarios.
    quantity = form.products.elementAt(index).quantity;
    productDB = await ProductRepo().fetchProduct(inputCode);
    inventoryStock =
        await InventoryRepo().fetchRowByCode(inputCode, warehouse.name);
    //Valida si hay stock suficiente.
    if (inventoryStock != null && quantity > inventoryStock.stock) {
      stockExist = true;
    } else {
      stockExist = false;
    }

    //Sí el producto existe, lo agrega a la lista de movimientos que está por
    // emitir.
    if (productDB != null && inventoryStock != null) {
      moveRow = InventoryMoveRowModel(
          code: form.products[index].code,
          description: productDB.description,
          quantity: inventoryStock.stock,
          weightUnit: productDB.weight!,
          weightTotal: productDB.weight! * quantity,
          concept: form.concept,
          stockExist: stockExist,
          states: {});
    } else {
      moveRow = InventoryMoveRowModel(
          code: inputCode, //productDB['code'].toString(),
          description: 'Producto no existent',
          quantity: form.products[index].quantity,
          weightUnit: 0,
          weightTotal: 0,
          concept: form.concept,
          stockExist: stockExist,
          states: {});
    }
    list[i] = product;
    elements = InventoryMoveModel(
      products: list,
      concept: current.concept,
      date: current.date,
      document: current.document,
      concepts: current.concepts,
      invTransfer: current.invTransfer,
      states: {},
    );
  }

  Future<void> editCode(int i, String currentCode, String inventoryName,
      InventoryMoveModel current) async {
    List<InventoryMoveRowModel> list = current.products;
    InventoryMoveModel elements;
    Map<String, dynamic> productDB = {};
    InventoryModel? productStock;
    InventoryMoveRowModel product;
    double weight;
    double total;
    double quantity;
    bool stockExist = false;
    //Buscar currentCode en la base de datos y obtiene los datos ncesarios.
    quantity = double.parse(list.elementAt(i).quantity);
    //productDB = await ProductRepo().fetchProduct(currentCode);
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
          stockExist: stockExist,
          states: {});
    } else {
      total = quantity * 0;
      product = InventoryMoveRowModel(
          code: currentCode, //productDB['code'].toString(),
          description: '',
          quantity: quantity.toString(),
          weightUnit: 0,
          weightTotal: total,
          concept: list.elementAt(i).concept,
          stockExist: stockExist,
          states: {});
    }
    list[i] = product;
    elements = InventoryMoveModel(
        products: list,
        concept: current.concept,
        date: current.date,
        document: current.document,
        concepts: current.concepts,
        invTransfer: current.invTransfer,
        states: {});
    emit(InitialState());
    emit(LoadedState(form: elements));
  }

  Future<void> editQuantity(int i, String currentQuantity, String inventoryName,
      InventoryMoveModel current) async {
    List<InventoryMoveRowModel> list = current.products;
    InventoryMoveModel elements;
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
        if (quantity > productDB.stock &&
            current.concepts
                    .where((x) => x.concept == current.concept)
                    .first
                    .type ==
                1) {
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
          stockExist: stockExist,
          states: {});
      list[i] = product;
    }
    elements = InventoryMoveModel(
        products: list,
        concept: current.concept,
        date: current.date,
        document: current.document,
        concepts: current.concepts,
        invTransfer: current.invTransfer,
        states: {});
    emit(InitialState());
    emit(LoadedState(form: elements));
  }

  Future<void> showConcepts(InventoryMoveModel current) async {
    //Muestra los conceptos de inventario guardado en la base de datos.
    //List<String> concepts = [];
    List<InventoryMoveConceptModel> conceptsDB;
    InventoryMoveModel elements;

    conceptsDB = await InventoryConceptsRepo().fetchAllConcepts();
    /*for (var element in conceptsDB) {
      concepts.add(element.concept.toString());
    }*/
    elements = InventoryMoveModel(
        products: current.products,
        concept: current.concept,
        date: current.date,
        document: current.document,
        concepts: conceptsDB,
        invTransfer: current.invTransfer,
        states: {});
    emit(InitialState());
    emit(LoadedState(form: elements));
  }

  /*Future<void> selectConcept(
      String concept, InventoryMoveModel current) async {
    InventoryMoveModel elements;

    elements = InventoryMoveModel(
      products: current.products,
      concept: concept,
      date: current.date,
      document: current.document,
      concepts: current.concepts,
      invTransfer: current.invTransfer,
      states: {}
    );
    emit(InitialState());
    emit(LoadedState(form: elements));
  }*/

  Future<void> editDocument(String document, InventoryMoveModel current) async {
    InventoryMoveModel elements;

    elements = InventoryMoveModel(
        products: current.products,
        concept: current.concept,
        date: current.date,
        document: document,
        concepts: current.concepts,
        invTransfer: current.invTransfer,
        states: {});
    emit(InitialState());
    emit(LoadedState(form: elements));
  }

  Future<void> saveMovements(
      InventoryMoveModel current, String inventory1) async {
    try {
      InventoryMoveModel currentRedux;
      List<InventoryMoveRowModel> productsRedux = [];
      MovementModel movement;
      List<MovementModel> movements = [];
      InventoryMoveConceptModel conceptModel;
      bool successValidatio = true;
      String errorMessage = '';
      int conceptType = -1;
      UserModel userModel;
      InventoryModel? inventoryModel;
      double stock = 0;

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
        currentRedux = InventoryMoveModel(
            products: productsRedux,
            concept: current.concept,
            date: current.date,
            document: current.document,
            concepts: current.concepts,
            invTransfer: current.invTransfer,
            states: {});

        //Craa la lista de movimientos que agragara al historial, en base de
        // 'currentRedux'.
        conceptModel = currentRedux.concepts.elementAt(currentRedux.concepts
            .indexWhere((value) => value.concept == current.concept));
        userModel = await LocalUser().getLocalUser();
        for (var element in currentRedux.products) {
          inventoryModel =
              await InventoryRepo().fetchRowByCode(element.code, inventory1);
          if (inventoryModel != null) {
            if (conceptModel.type == 0) {
              stock = inventoryModel.stock + double.parse(element.quantity);
            } else if (conceptModel.type == 1) {
              stock = inventoryModel.stock - double.parse(element.quantity);
            }
          } else {
            stock = 0;
          }
          movement = MovementModel(
            id: const Uuid().v4(),
            code: element.code,
            concept: conceptModel.id,
            conceptType: conceptModel.type,
            description: element.description,
            document: currentRedux.document,
            quantity: double.parse(element.quantity),
            time: DateTime.now(),
            warehouse: inventory1,
            user: userModel.name,
            stock: stock,
          );
          movements.add(movement);
          if (conceptModel.id == 58) {
            inventoryModel = await InventoryRepo()
                .fetchRowByCode(element.code, currentRedux.invTransfer);
            if (inventoryModel != null) {
              stock = inventoryModel.stock + double.parse(element.quantity);
            } else {
              stock = double.parse(element.quantity);
            }
            movement = MovementModel(
                id: const Uuid().v4(),
                code: element.code,
                concept: 7,
                conceptType: 0,
                description: element.description,
                document: currentRedux.document,
                quantity: double.parse(element.quantity),
                time: DateTime.now(),
                warehouse: currentRedux.invTransfer,
                user: userModel.name,
                stock: stock);
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
      InventoryMoveModel current, String inventory2) async {
    InventoryMoveModel newElement = InventoryMoveModel(
        products: current.products,
        concept: current.concept,
        date: current.date,
        document: current.document,
        concepts: current.concepts,
        invTransfer: inventory2,
        states: {});
    emit(InitialState());
    emit(LoadedState(form: newElement));
  }
}
