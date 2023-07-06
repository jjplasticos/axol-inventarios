import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../models/warehouse_model.dart';

class WarehousesRepo {
  //Nombre de tabla
  static const String _table = 'warehouses';
  //Columnas
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _retailManager = 'retail_manager';
  //Base de datos
  final _supabase = Supabase.instance.client;

  Future<List<String>> fetchNames() async {
    List<String> names = [];
    List<Map<String, dynamic>> warehouses = [];

    warehouses =
        await _supabase.from(_table).select<List<Map<String, dynamic>>>();

    for (var element in warehouses) {
      names.add(element[_name]);
    }

    return names;
  }

  Future<WarehouseModel?> fetchWarehouse(String name) async {
    WarehouseModel? warehouse;
    List<Map<String, dynamic>> warehouses = [];
    warehouses = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .eq(_name, name);
    if (warehouses.length == 1) {
      warehouse = WarehouseModel(
        id: warehouses.single[_id],
        name: warehouses.single[_name].toString(),
        retailManager: warehouses.single[_retailManager].toString(),
      );
    } else {
      warehouse = null;
    }
    return warehouse;
  }

  Future<List<WarehouseModel>> fetchAllWarehouses() async {
    List<WarehouseModel> warehouses = [];
    WarehouseModel warehouse;
    List<Map<String, dynamic>> warehousesDB = [];
    warehousesDB =
        await _supabase.from(_table).select<List<Map<String, dynamic>>>();
    if (warehousesDB.isNotEmpty) {
      for (var element in warehousesDB) {
        warehouse = WarehouseModel(
            id: element[_id],
            name: element[_name].toString(),
            retailManager: element[_retailManager].toString());
        warehouses.add(warehouse);
      }
    }
    return warehouses;
  }

  Future<void> insertWarehouse(WarehouseModel warehouse) async {
    await _supabase.from(_table).insert({
      _id: warehouse.id,
      _name: warehouse.name,
      _retailManager: warehouse.retailManager
    });
  }

  Future<void> updateWarehouse(WarehouseModel warehouse) async {
    await _supabase.from(_table).update({
      _name: warehouse.name,
      _retailManager: warehouse.retailManager
    }).eq(_id, warehouse.id);
  }

  Future<void> deleteWarehouse(int id) async {
    await _supabase.from(_table).delete().eq(_id, id);
  }
}
