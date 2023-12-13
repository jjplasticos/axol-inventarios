import 'package:axol_inventarios/models/user_mdoel.dart';
import 'package:axol_inventarios/plugins/inventory_/inventory/model/warehouse_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../models/inventory_model.dart';
import '../../../../../utilities/data_state.dart';
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

    form.states[form.tConcepts]!.state = DataState.loading;
    list.add(InventoryMoveRowModel.empty());
    form.moveList = list;
    emit(LoadedState(form: form));
    form.concepts = await InventoryConceptsRepo().fetchAllConcepts();
    form.states[form.tConcepts]!.state = DataState.loaded;
    emit(InitialState());
    emit(LoadedState(form: form));
  }

  void load(InventoryMoveModel form) {
    emit(InitialState());
    emit(LoadedState(form: form));
  }

  Future<void> enterCode(final int index, final InventoryMoveModel form,
      final String inputCode, WarehouseModel warehouse) async {
    emit(InitialState());
    //final double quantity;
    final ProductModel? productDB;
    final InventoryModel? inventoryRow;
    //final bool stockExist;
    final InventoryMoveRowModel moveRow = form.moveList[index];
    InventoryMoveModel upForm = form;
    InventoryMoveRowModel upMoveRow = moveRow;

    upForm.moveList[index].states[moveRow.tCode] =
        DataState(state: DataState.loading);
    emit(LoadedState(form: upForm));
    //Buscar currentCode en la base de datos y obtiene los datos ncesarios.
    //quantity = form.moveList.elementAt(index).quantity;
    productDB = await ProductRepo().fetchProduct(inputCode);
    inventoryRow =
        await InventoryRepo().fetchRowByCode(inputCode, warehouse.name);

    //Valida si hay stock suficiente.
    /*if (inventoryRow != null && quantity > inventoryRow.stock) {
      stockExist = true;
    } else {
      stockExist = false;
    }*/

    //Sí el producto existe, lo agrega a la lista de movimientos que está por
    // emitir.
    if (productDB != null && inventoryRow != null) {
      upMoveRow.description = productDB.description;
      upMoveRow.weightUnit = productDB.weight!;
      upMoveRow.weightTotal = moveRow.quantity * moveRow.weightUnit;
      upMoveRow.states[moveRow.tCode] = DataState(state: DataState.loaded);
    } else {
      upMoveRow.states[moveRow.tCode] =
          DataState(state: DataState.error, message: moveRow.emNotProduct);
    }
    upForm.moveList[index] = upMoveRow;
    emit(InitialState());
    emit(LoadedState(form: upForm));
  }

  Future<void> enterQuantity(final int index, final WarehouseModel warehouse,
      final InventoryMoveModel form) async {
    final InventoryMoveRowModel moveRow = form.moveList[index];
    InventoryMoveModel upForm = form;
    InventoryMoveRowModel upMoveRow = moveRow;
    InventoryModel? inventoryRow;
    bool stockExist = false;

    emit(InitialState());
    upMoveRow.states[moveRow.tQuantity] = DataState(state: DataState.loading);
    upForm.moveList[index] = upMoveRow;
    emit(LoadedState(form: upForm));
    inventoryRow =
        await InventoryRepo().fetchRowByCode(moveRow.code, warehouse.name);

    if (inventoryRow != null) {
      if (moveRow.quantity > inventoryRow.stock &&
          form.concepts.where((x) => x.concept == form.concept).first.type ==
              1) {
        stockExist = true;
      } else {
        stockExist = false;
      }
    } else {
      upMoveRow.states[moveRow.tCode] =
          DataState(state: DataState.error, message: moveRow.emNotProduct);
    }

    upMoveRow.weightTotal = moveRow.quantity * moveRow.weightUnit;
    upMoveRow.stockExist = stockExist;
    upMoveRow.states[moveRow.tQuantity] = DataState(state: DataState.loaded);
    upForm.moveList[index] = upMoveRow;

    emit(InitialState());
    emit(LoadedState(form: upForm));
  }

  Future<void> checkErrorsMoveList(final InventoryMoveModel form, WarehouseModel warehouse) async {
    InventoryMoveRowModel moveRow;
    for (int i = 0; i < form.moveList.length; i++) {
      moveRow = form.moveList[i];
      if (moveRow.states[moveRow.tCode]!.state == DataState.error) {
        enterCode(i, form, moveRow.code, warehouse);
      }
      if (moveRow.states[moveRow.tQuantity]!.state == DataState.error) {
        enterQuantity(i, warehouse, form);
      }
    }
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
        moveList: current.moveList,
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
        moveList: current.moveList,
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
      for (var element in current.moveList) {
        //si es concepto de salida...
        if (conceptType == 1) {
          if (element.stockExist == true) {
            successValidatio = false;
            errorMessage = 'La cantidad supera el stock disponible.';
          }
        }
        if (element.description != '' && element.quantity > 0) {
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
            moveList: productsRedux,
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
        for (var element in currentRedux.moveList) {
          inventoryModel =
              await InventoryRepo().fetchRowByCode(element.code, inventory1);
          if (inventoryModel != null) {
            if (conceptModel.type == 0) {
              stock = inventoryModel.stock + element.quantity;
            } else if (conceptModel.type == 1) {
              stock = inventoryModel.stock - element.quantity;
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
            quantity: element.quantity,
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
              stock = inventoryModel.stock + element.quantity;
            } else {
              stock = element.quantity;
            }
            movement = MovementModel(
                id: const Uuid().v4(),
                code: element.code,
                concept: 7,
                conceptType: 0,
                description: element.description,
                document: currentRedux.document,
                quantity: element.quantity,
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
        moveList: current.moveList,
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
