import 'package:axol_inventarios/plugins/inventory_/product/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/inventory_model.dart';
import '../../../../models/inventory_row_model.dart';
import '../../movements/model/movement_model.dart';
import '../../product/repository/product_repo.dart';
import 'warehouses_repo.dart';

class InventoryRepo {
  //Tabla
  static const String _table = 'inventory';
  //--Columnas
  static const String _stock = 'stock';
  static const String _manager = 'retail_manager';
  static const String _code = 'code';
  static const String _name = 'name';
  static const String _id = 'uid';
  //Memoria local
  static const String _user = 'user_name';
  //Otros
  static const String _description = 'description';
  //Instancia a la base de datos
  final _supabase = Supabase.instance.client;

  Future<List<InventoryRowModel>> getInventoryList(
      String inventoryName, String filter) async {
    List<InventoryRowModel> inventoryList = [];
    List<InventoryRowModel> finalInventoryList = [];
    InventoryRowModel inventoryRow;
    ProductModel productModel;
    List<String> codes = [];
    //Lee en la base de datos el inventario del usuario registrado.
    //y obtiene una lista de claves de las existencias en inventario.
    final List<Map<String, dynamic>> inventoryDB =
        await fetchInventory(inventoryName);
    for (Map<String, dynamic> element in inventoryDB) {
      if (double.parse(element[_stock].toString()) > 0) {
        codes.add(element[_code]);
      }
    }
    //Obtiene la lista de productos: {code: Map<String,dynamic>}
    final List<ProductModel> productsDB =
        await ProductRepo().fetchProductList(codes);
    //Llena inventoryList con iteraciones de codes y utilizando los elementos
    // de productDB e inventoryDB.
    for (String element in codes) {
      productModel = productsDB
          .elementAt(productsDB.indexWhere((value) => value.code == element));
      /*productModel = ProductModel(
          code: element,
          description: productModel.description,
          properties: productModel.properties);*/
      inventoryRow = InventoryRowModel(
          product: productModel,
          /*code: element,
          properties:
              productsDB.where((value) => value[_code] == element).first,*/
          stock: double.parse(inventoryDB
              .where((value) => value[_code] == element)
              .first[_stock]
              .toString()));
      inventoryList.add(inventoryRow);
    }
    //Filtra la lista
    if (filter != '') {
      for (var element in inventoryList) {
        if (element.product.code.contains(filter) ||
            element.product.properties![_description]
                .toString()
                .contains(filter)) {
          finalInventoryList.add(element);
        }
      }
    } else {
      finalInventoryList = inventoryList;
    }

    return finalInventoryList;
  }

  Future<List<Map<String, dynamic>>> fetchInventory(
      String? inventoryName) async {
    final String name;
    List<Map<String, dynamic>> inventoryList = [];

    if (inventoryName != null) {
      name = inventoryName;
    } else {
      final pref = await SharedPreferences.getInstance();
      name = pref.getString(_user)!;
    }

    inventoryList = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .eq(_name, name);
    return inventoryList;
  }

  Future<InventoryModel?> fetchRowByCode(
      String code, String? inventoryName) async {
    final String name;
    InventoryModel? inventoryRow;
    List<Map<String, dynamic>> inventoryList = [];

    if (inventoryName != null) {
      name = inventoryName;
    } else {
      final pref = await SharedPreferences.getInstance();
      name = pref.getString(_user)!;
    }
    inventoryList = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .eq(_name, name)
        .eq(_code, code);
    if (inventoryList.isNotEmpty) {
      inventoryRow = InventoryModel(
          code: inventoryList.first[_code].toString(),
          id: inventoryList.first[_id].toString(),
          name: inventoryList.first[_name].toString(),
          retailManager: inventoryList.first[_manager].toString(),
          stock: inventoryList.first[_stock]);
    } else {
      inventoryRow = null;
    }
    return inventoryRow;
  }

  Future<void> updateInventory(List<MovementModel> movements) async {
    double currentStock = -1;
    double newStock = -1;
    InventoryModel? inventoryModel;
    InventoryModel newInventoryRow;
    List<String> inventories = [];

    for (var element in movements) {
      inventoryModel = await fetchRowByCode(element.code, element.warehouse);
      if (inventoryModel != null) {
        currentStock = inventoryModel.stock;
        if (element.conceptType == 0) {
          newStock = currentStock + element.quantity;
        } else if (element.conceptType == 1) {
          newStock = currentStock - element.quantity;
        }
        if (newStock >= 0) {
          await _supabase
              .from(_table)
              .update({_stock: newStock})
              .eq(_code, inventoryModel.code)
              .eq(_name, inventoryModel.name);
        }
      } else {
        inventories = await WarehousesRepo().fetchNames();
        if (inventories.contains(element.warehouse) &&
            element.conceptType == 0) {
          newInventoryRow = InventoryModel(
              code: element.code,
              id: const Uuid().v4(),
              name: element.warehouse,
              retailManager: '',
              stock: element.quantity);
          await insertInventoryRow(newInventoryRow);
        }
      }
    }
  }

  Future<void> insertInventoryRow(InventoryModel inventory) async {
    await _supabase.from(_table).insert({
      _id: inventory.id,
      _code: inventory.code,
      _stock: inventory.stock,
      _name: inventory.name,
      _manager: inventory.retailManager,
    });
  }
}
