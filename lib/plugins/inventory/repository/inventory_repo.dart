import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../models/inventory_row_model.dart';

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

  Future<List<InventoryRowModel>> getInventoryList() async {
    List<InventoryRowModel> inventoryList = [];
    //Map<String, String> productsMap = {};
    //Map<String, dynamic> element;
    final List inventoryDB = await readInventory();

    if (inventoryDB.isNotEmpty) {
      for (var element in inventoryList) {
        //productsMap[element[CODE].toString()] = element[STOCK].toString();
      }
    } else {}
    return inventoryList;
  }

  Future<List> readInventory() async {
    List<Map<String, dynamic>> productsList = [];
    final String userName;
    List inventoryList = [];

    final pref = await SharedPreferences.getInstance();
    userName = pref.getString(USER)!;
    inventoryList = await supabase
        .from(TABLE)
        .select<List<Map<String, dynamic>>>()
        .eq(NAME, userName);
    return inventoryList;
  }
}
