import 'package:axol_inventarios/plugins/sale_note/model/customer_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerRepo {
  static const String _table = 'customers';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _properties = 'properties';
  final _supabase = Supabase.instance.client;

  Future<List<CustomerModel>> fetchCustomersEq(String inText) async {
    List<Map<String, dynamic>> customersDB = [];
    List<CustomerModel> customers = [];
    CustomerModel customer;
    customersDB = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .or('$_id.eq.$inText,$_name.eq.$inText');
    if (customersDB.isNotEmpty) {
      for (var element in customersDB) {
        customer = CustomerModel(
          id: element[_id],
          name: element[_name],
          country: element[_properties][CustomerModel.propCountry],
          hood: element[_properties][CustomerModel.propHood],
          intNumber: element[_properties][CustomerModel.propIntNumber],
          outNumber: element[_properties][CustomerModel.propOutNumber],
          phoneNumber: element[_properties][CustomerModel.propPhoneNumber],
          postalCode: element[_properties][CustomerModel.propPostalCode],
          rfc: element[_properties][CustomerModel.propRfc],
          street: element[_properties][CustomerModel.propStreet],
          town: element[_properties][CustomerModel.propTown],
        );
        customers.add(customer);
      }
    }
    return customers;
  }

  Future<List<CustomerModel>> fetchCustomersIlike(String inText) async {
    List<Map<String, dynamic>> customersDB = [];
    List<CustomerModel> customers = [];
    CustomerModel customer;
    customersDB = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .or('$_id.ilike.$inText,$_name.ilike.$inText');
    if (customersDB.isNotEmpty) {
      for (var element in customersDB) {
        customer = CustomerModel(
          id: element[_id],
          name: element[_name],
          country: element[_properties][CustomerModel.propCountry],
          hood: element[_properties][CustomerModel.propHood],
          intNumber: element[_properties][CustomerModel.propIntNumber],
          outNumber: element[_properties][CustomerModel.propOutNumber],
          phoneNumber: element[_properties][CustomerModel.propPhoneNumber],
          postalCode: element[_properties][CustomerModel.propPostalCode],
          rfc: element[_properties][CustomerModel.propRfc],
          street: element[_properties][CustomerModel.propStreet],
          town: element[_properties][CustomerModel.propTown],
        );
        customers.add(customer);
      }
    }
    return customers;
  }
}
