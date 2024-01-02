import 'package:axol_inventarios/models/user_mdoel.dart';
import 'package:axol_inventarios/modules/inventory_/inventory/model/warehouse_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../models/inventory_model.dart';
import '../../../../../utilities/data_state.dart';
import '../../../product/model/product_model.dart';
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
    final InventoryMoveRowModel moveRow = form.moveList[index];
    InventoryMoveModel upForm = form;
    InventoryMoveRowModel upMoveRow = moveRow;

    upForm.moveList[index].states[moveRow.tCode] =
        DataState(state: DataState.loading);
    emit(LoadedState(form: upForm));

    //Buscar currentCode en la base de datos y obtiene los datos necesarios.
    productDB = await ProductRepo().fetchProduct(inputCode);

    //Sí el producto existe, lo agrega a la lista de movimientos que está por
    // emitir.
    if (productDB != null){
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
    final ProductModel? productDB;

    emit(InitialState());
    upMoveRow.states[moveRow.tQuantity] = DataState(state: DataState.loading);
    upForm.moveList[index] = upMoveRow;
    emit(LoadedState(form: upForm));
    inventoryRow =
        await InventoryRepo().fetchRowByCode(moveRow.code, warehouse.name);
    productDB = await ProductRepo().fetchProduct(moveRow.code);
    if (form.concept.type == 1 && inventoryRow != null) {
      if (moveRow.quantity > inventoryRow.stock &&
          form.concepts.where((x) => x.text == form.concept.text).first.type ==
              1) {
        upMoveRow.states[moveRow.tQuantity] =
            DataState(state: DataState.error, message: moveRow.emNotStock);
      } else {
        upMoveRow.weightTotal = moveRow.quantity * moveRow.weightUnit;
        upMoveRow.states[moveRow.tQuantity] =
            DataState(state: DataState.loaded);
      }
    } else if (form.concept.type == 0 && productDB != null) {
      upMoveRow.weightTotal = moveRow.quantity * moveRow.weightUnit;
      upMoveRow.states[moveRow.tQuantity] = DataState(state: DataState.loaded);
    } else {
      upMoveRow.states[moveRow.tQuantity] =
          DataState(state: DataState.error, message: moveRow.emNotStock);
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

  Future<void> saveMovements(
      final InventoryMoveModel form, final WarehouseModel warehouse) async {
    InventoryMoveModel upForm = form;
    MovementModel regMove;
    List<MovementModel> regMoveList = [];
    double stock = 0;
    List<InventoryMoveRowModel> upMoveList;
    Map<String, InventoryMoveRowModel> mapMoveList = {};
    UserModel user;
    Map<String, InventoryModel> inventoryMap = {};
    InventoryModel? inventoryRow;
    List<InventoryModel> inventoryList = [];
    List<InventoryModel> inventoryListDestiny = [];

    try {
      emit(InitialState());
      emit(SaveLoadingState());
      //Valida si se seleccionó un concepto.
      if (form.concept.text == '') {
        form.states[form.tSave]!.state = DataState.error;
        form.states[form.tSave]!.message = form.emSelectConcept;
        emit(ErrorState(error: form.emSelectConcept));
        return;
      }

      //Valida si se hay al menos una fila en la lista de movimientos.
      if (form.moveList.isEmpty) {
        form.states[form.tSave]!.state = DataState.error;
        form.states[form.tSave]!.message = form.emNotRow;
        emit(ErrorState(error: form.emNotRow));
        return;
      } else {
        for (var element in form.moveList) {
          if (element.code == '' || element.quantity <= 1) {
            form.states[form.tSave]!.state = DataState.error;
            form.states[form.tSave]!.message = form.emRowMissing;
            emit(ErrorState(error: form.emRowMissing));
            return;
          }
        }
      }

      //Valida si hay algún error en las filas de la lista.
      for (var moveRow in form.moveList) {
        if (moveRow.states[moveRow.tCode]!.state == DataState.error) {
          form.states[form.tSave]!.state = DataState.error;
          form.states[form.tSave]!.message = form.emNotProduct;
          emit(ErrorState(error: form.emNotProduct));
          return;
        }
        if (moveRow.states[moveRow.tQuantity]!.state == DataState.error) {
          form.states[form.tSave]!.state = DataState.error;
          form.states[form.tSave]!.message = form.emNotStock;
          emit(ErrorState(error: form.emNotStock));
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
          emit(ErrorState(error: form.emNotStock));
          return;
        } else {
          inventoryMap[row.code]!.stock = stock;
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
          regMove = MovementModel.transferDestiny(
              upForm, row, upForm.invTransfer, user.name, stock);
          regMoveList.add(regMove);
          inventoryListDestiny = inventoryMap.values.toList();
        }
      }
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    } finally {
      if (state is SaveLoadingState) {
        //Guarda los registros en caso de no existir errores.
        //Lista con movimientos a registrar: regMoveList
        await MovementRepo().insertMovemets(regMoveList);
        //Lista con registros de inventario nuevos: inventoryList
        await InventoryRepo().updateInventory(inventoryList);
        //Lista con registros de inventario destino: inventoryListDestiny
        await InventoryRepo().updateInventory(inventoryListDestiny);
        emit(SaveLoadedState());
      }
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
