import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/routcustomer_model.dart';

class RoutcustomerRepo {
  static const String _table = 'route_customer';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _location = 'location';
  static const String _validation = 'validation';
  static const String _address = 'address';
  final _supabase = Supabase.instance.client;

  Future<List<RoutcustomerModel>> fetchRcList(String finder) async {
    List<Map<String, dynamic>> customersDB = [];
    RoutcustomerModel routcustomer;
    List<RoutcustomerModel> customers = [];
    if (finder == '') {
      customersDB =
          await _supabase.from(_table).select<List<Map<String, dynamic>>>();
    } else {
      customersDB = await _supabase
          .from(_table)
          .select<List<Map<String, dynamic>>>()
          .ilike(_name, '%$finder%');
    }
    if (customersDB.isNotEmpty) {
      for (var element in customersDB) {
        routcustomer = RoutcustomerModel(
          id: element[_id],
          name: element[_name],
          location: element[_location],
          address: element[_address],
          validation: element[_validation],
        );
        customers.add(routcustomer);
      }
    }
    return customers;
  }
}
