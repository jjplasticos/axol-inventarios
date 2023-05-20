import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../models/inventory_row_model.dart';
import 'product_repo.dart';

class InventoryRepo {
  //Tabla
  final String TABLE = 'inventory';
  //--Columnas
  final String STOCK = 'stock';
  final String MANAGER = 'retail_manager';
  final String CODE = 'code';
  final String NAME = 'name';
  final String UID = 'uid';
  //Memoria local
  final String USER = 'user_name';
  //Otros
  final String SHOPPINGCART = 'shoppingcart';
  final String DESCRIPTION = 'description';
  final String WEIGHT = 'weight';
  final String PRICE = 'price';
  final String QUANTITY = 'quantity';
  //Instancia a la base de datos
  final supabase = Supabase.instance.client;

  Future<List<InventoryRowModel>> getInventoryList(
      String inventoryName, String filter) async {
    List<InventoryRowModel> inventoryList = [];
    List<InventoryRowModel> finalInventoryList = [];
    InventoryRowModel inventoryRow;
    List<String> codes = [];
    //Lee en la base de datos el inventario del usuario registrado.
    //y obtiene una lista de claves de las existencias en inventario.
    final List<Map<String, dynamic>> inventoryDB =
        await fetchInventory(inventoryName);
    print(inventoryDB);
    for (Map<String, dynamic> element in inventoryDB) {
      if (double.parse(element[STOCK].toString()) > 0) {
        codes.add(element[CODE]);
      }
    }
    //Obtiene la lista de productos: {code: Map<String,dynamic>}
    final List<Map<String, dynamic>> productsDB =
        await ProductRepo().fetchProductList(codes);
    print(productsDB);
    //Llena inventoryList con iteraciones de codes y utilizando los elementos
    // de productDB e inventoryDB.
    for (String element in codes) {
      inventoryRow = InventoryRowModel(
          code: element,
          properties: productsDB.where((value) => value[CODE] == element).first,
          stock: double.parse(inventoryDB
              .where((value) => value[CODE] == element)
              .first[STOCK]
              .toString()));
      inventoryList.add(inventoryRow);
    }
    //Filtra la lista
    if (filter != '') {
      for (var element in inventoryList) {
        if (element.code.contains(filter) ||
            element.properties[DESCRIPTION].toString().contains(filter)) {
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
      name = pref.getString(USER)!;
    }

    inventoryList = await supabase
        .from(TABLE)
        .select<List<Map<String, dynamic>>>()
        .eq(NAME, name);
    return inventoryList;
  }

  Future<Map<String, dynamic>> fetchRowByCode(
      String code, String? inventoryName) async {
    final String name;
    Map<String, dynamic> inventoryRow;
    List<Map<String, dynamic>> inventoryList = [];

    if (inventoryName != null) {
      name = inventoryName;
    } else {
      final pref = await SharedPreferences.getInstance();
      name = pref.getString(USER)!;
    }
    inventoryList = await supabase
        .from(TABLE)
        .select<List<Map<String, dynamic>>>()
        .eq(NAME, name)
        .eq(CODE, code);
    if (inventoryList.isNotEmpty) {
      inventoryRow = inventoryList.first;
    } else {
      inventoryRow = {};
    }
    return inventoryRow;
  }
}
