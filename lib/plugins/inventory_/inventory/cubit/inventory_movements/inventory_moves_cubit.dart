import 'package:axol_inventarios/models/user_mdoel.dart';
import 'package:axol_inventarios/plugins/inventory_/inventory/model/warehouse_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../models/inventory_model.dart';
import '../../../../../utilities/data_state.dart';
import '../../../product/model/product_model.dart';
import '../../model/inventory_move/concept_move_model.dart';
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
    final ProductModel? productDB;
    final InventoryModel? inventoryRow;
    final InventoryMoveRowModel moveRow = form.moveList[index];
    InventoryMoveModel upForm = form;
    InventoryMoveRowModel upMoveRow = moveRow;

    upForm.moveList[index].states[moveRow.tCode] =
        DataState(state: DataState.loading);
    emit(LoadedState(form: upForm));

    //Buscar currentCode en la base de datos y obtiene los datos ncesarios.
    productDB = await ProductRepo().fetchProduct(inputCode);
    inventoryRow =
        await InventoryRepo().fetchRowByCode(inputCode, warehouse.name);

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

    emit(InitialState());
    upMoveRow.states[moveRow.tQuantity] = DataState(state: DataState.loading);
    upForm.moveList[index] = upMoveRow;
    emit(LoadedState(form: upForm));
    inventoryRow =
        await InventoryRepo().fetchRowByCode(moveRow.code, warehouse.name);

    if (inventoryRow != null) {
      if (moveRow.quantity > inventoryRow.stock &&
          form.concepts.where((x) => x.text == form.concept).first.type == 1) {
        upMoveRow.states[moveRow.tQuantity] =
            DataState(state: DataState.error, message: moveRow.emNotStock);
      } else {
        upMoveRow.weightTotal = moveRow.quantity * moveRow.weightUnit;
        upMoveRow.states[moveRow.tQuantity] =
            DataState(state: DataState.loaded);
      }
    } else {
      upMoveRow.states[moveRow.tCode] =
          DataState(state: DataState.error, message: moveRow.emNotProduct);
    }
    upForm.moveList[index] = upMoveRow;

    emit(InitialState());
    emit(LoadedState(form: upForm));
  }

  Future<void> checkErrorsMoveList(
      final InventoryMoveModel form, WarehouseModel warehouse) async {
    InventoryMoveRowModel moveRow;
    for (int i = 0; i < form.moveList.length; i++) {
      moveRow = form.moveList[i];
      if (moveRow.states[moveRow.tQuantity]!.state != DataState.initial) {
        enterQuantity(i, warehouse, form);
      }
    }
  }

  /*Future<void> editDocument(String document, InventoryMoveModel current) async {
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
  }*/

  Future<void> saveMovements(
      final InventoryMoveModel form, final WarehouseModel warehouse) async {
    try {
      InventoryMoveModel currentRedux;
      InventoryMoveModel upForm = form;
      List<InventoryMoveRowModel> movesRedux = [];
      MovementModel regMove;
      List<MovementModel> regMoveList = [];
      ConceptMoveModel conceptModel;
      bool successValidatio = true;
      String errorMessage = '';
      int conceptType = -1;
      UserModel userModel;
      InventoryModel? inventoryModel;
      double stock = 0;
      bool hasQuantityError = false;
      bool hasCodeError = false;
      List<InventoryMoveRowModel> upMoveList;
      Map<String, InventoryMoveRowModel> mapMoveList = {};
      UserModel user;
      Map<String, InventoryModel> inventoryMap = {};
      InventoryModel? inventoryRow;
      List<InventoryModel> inventoryList = [];
      List<InventoryModel> inventoryListDestiny = [];

      try {
        //Valida si se seleccionó un concepto.
        if (form.concept.text == '') {
          form.states[form.tSave]!.state = DataState.error;
          form.states[form.tSave]!.message = form.emSelectConcept;
          return;
        } else {
          conceptType = form.concept.type;
        }

        //Valida si se hay al menos una fila en la lista de movimientos.
        if (form.moveList.isEmpty) {
          form.states[form.tSave]!.state = DataState.error;
          form.states[form.tSave]!.message = form.emNotRow;
          return;
        }

        //Valida si hay algún error en las filas de la lista.
        for (var moveRow in form.moveList) {
          if (moveRow.states[moveRow.tCode]!.state == DataState.error) {
            form.states[form.tSave]!.state = DataState.error;
            form.states[form.tSave]!.message = form.emNotProduct;
            return;
          }
          if (moveRow.states[moveRow.tQuantity]!.state == DataState.error) {
            form.states[form.tSave]!.state = DataState.error;
            form.states[form.tSave]!.message = form.emNotStock;
            return;
          }
        }

        //Reduce las filas sumando los que tienene la misma clave.
        for (var moveRow in form.moveList) {
          if (mapMoveList.keys.contains(moveRow.code)) {
            var row = mapMoveList[moveRow.code]!;
            row.quantity = row.quantity + moveRow.quantity;
            row.weightTotal = row.quantity * row.weightUnit;
            mapMoveList[moveRow.code] = row;
          } else {
            mapMoveList[moveRow.code] = moveRow;
          }
        }
        upMoveList = mapMoveList.values.toList();

        //Obtiene los registros de inventario actuales de la lista reducida
        for (var row in upForm.moveList) {
          inventoryRow =
              await InventoryRepo().fetchRowByCode(row.code, warehouse.name);
          if (inventoryRow != null) {
            inventoryMap[row.code] = inventoryRow;
          } else {
            inventoryMap[row.code] =
                InventoryModel.stockZero(row.code, warehouse);
          }
        }

        //Crea un registro de movimiento por cada fila de la lista actualizada.
        upForm.moveList = upMoveList;
        user = await LocalUser().getLocalUser();
        for (var row in upForm.moveList) {
          if (upForm.concept.type == 0) {
            stock = inventoryMap[row.code]!.stock + row.quantity;
          } else {
            stock = inventoryMap[row.code]!.stock - row.quantity;
          }
          if (stock < 0) {
            form.states[form.tSave]!.state = DataState.error;
            form.states[form.tSave]!.message = form.emNotStock;
            return;
          }
          regMove = MovementModel.fromRowOfDoc(
              upForm, row, warehouse.name, user.name, stock);
          regMoveList.add(regMove);
          inventoryList = inventoryMap.values.toList();
        }

        //Si el concepto es una salida de traspaso, obtiene los registors de 
        //inventario y crea los registros extra de entrada para el inventario destino.
        if (upForm.concept.id == 58) {
          inventoryMap = {};
          for (var row in upForm.moveList) {
            inventoryRow = await InventoryRepo()
                .fetchRowByCode(row.code, upForm.invTransfer);
            if (inventoryRow != null) {
              inventoryMap[row.code] = inventoryRow;
            } else {
              inventoryMap[row.code] =
                  InventoryModel.stockZero(row.code, warehouse);
            }
          }
          for (var row in upForm.moveList) {
            stock = inventoryMap[row.code]!.stock + row.quantity;
            regMove = MovementModel.transferDestiny(upForm, row, upForm.invTransfer, user.name, stock);
            regMoveList.add(regMove);
            inventoryListDestiny = inventoryMap.values.toList();
          }
        }
      } finally {
        //Guarda los registros en caso de no existir errores.
        //Tengo:
        //Lista con movimientos a registrar: regMoveList
        //Lista con registros de inventario nuevos: inventoryList
        //Lista con registros de inventario destino: inventoryListDestiny
      }

      /*if (form.states[form.tSave]!.state != DataState.error) {
        /*currentRedux = InventoryMoveModel(
            moveList: movesRedux,
            concept: form.concept,
            date: form.date,
            document: form.document,
            concepts: form.concepts,
            invTransfer: form.invTransfer,
            states: {});*/

        //Craa la lista de movimientos que agragara al historial, en base de
        // 'currentRedux'.
        conceptModel = currentRedux.concepts.elementAt(currentRedux.concepts
            .indexWhere((value) => value.text == form.concept.text));
        userModel = await LocalUser().getLocalUser();
        for (var element in currentRedux.moveList) {
          inventoryModel = await InventoryRepo()
              .fetchRowByCode(element.code, warehouse.name);
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
                .fetchRowByCode(element.code, form.invTransfer);
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
      }*/
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  /*Future<void> saveMovements(
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
  }*/

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

  List<MovementModel> _moveDocToRegList(
    InventoryMoveModel moveDoc,
    WarehouseModel warehouse,
    UserModel user,
  ) {
    List<MovementModel> regList = [];
    MovementModel regMove;
    for (var row in moveDoc.moveList) {
      regMove = MovementModel(
        id: const Uuid().v4(),
        code: row.code,
        concept: moveDoc.concept.id,
        conceptType: moveDoc.concept.type,
        description: row.description,
        document: moveDoc.document,
        quantity: row.quantity,
        time: DateTime.now(),
        warehouse: warehouse.name,
        user: user.name,
        stock: row.quantity,
      );
      regList.add(regMove);
    }
    return regList;
  }
}
