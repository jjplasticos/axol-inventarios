import 'package:supabase_flutter/supabase_flutter.dart';

class WarehousesRepo {
  Future<List<String>> fetchNames() async {
    //Nombre de tabla
    const String table_ = 'warehouses';
    //Columnas
    const String name_ = 'name';

    final supabase = Supabase.instance.client;
    List<String> names = [];
    List<Map<String, dynamic>> warehouses = [];

    warehouses =
        await supabase.from(table_).select<List<Map<String, dynamic>>>();

    for (var element in warehouses) {
      names.add(element[name_]);
    }

    return names;
  }
}
