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
    Map<String, dynamic> mapProp;
    String textOr;
    if (int.tryParse(inText) == null) {
      textOr = '$_name.eq.$inText';
    } else {
      textOr = '$_id.eq.$inText';
    }
    customersDB = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .or(textOr);
    //.or('$_id.eq.$inText,$_name.eq.$inText');
    if (customersDB.isNotEmpty) {
      for (var element in customersDB) {
        mapProp = element[_properties] ?? {};
        customer = CustomerModel(
          id: element[_id],
          name: element[_name],
          country: mapProp.containsKey(CustomerModel.propCountry)
              ? element[_properties][CustomerModel.propCountry]
              : null,
          hood: mapProp.containsKey(CustomerModel.propHood)
              ? element[_properties][CustomerModel.propHood]
              : null,
          intNumber: mapProp.containsKey(CustomerModel.propIntNumber)
              ? element[_properties][CustomerModel.propIntNumber]
              : null,
          outNumber: mapProp.containsKey(CustomerModel.propOutNumber)
              ? element[_properties][CustomerModel.propOutNumber]
              : null,
          phoneNumber: mapProp.containsKey(CustomerModel.propPhoneNumber)
              ? element[_properties][CustomerModel.propPhoneNumber]
              : null,
          postalCode: mapProp.containsKey(CustomerModel.propPostalCode)
              ? element[_properties][CustomerModel.propPostalCode]
              : null,
          rfc: mapProp.containsKey(CustomerModel.propRfc)
              ? element[_properties][CustomerModel.propRfc]
              : null,
          street: mapProp.containsKey(CustomerModel.propStreet)
              ? element[_properties][CustomerModel.propStreet]
              : null,
          town: mapProp.containsKey(CustomerModel.propTown)
              ? element[_properties][CustomerModel.propTown]
              : null,
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
    Map<String, dynamic> mapProp;
    String textOr;
    if (int.tryParse(inText) == null) {
      textOr = '$_name.ilike.$inText';
    } else {
      textOr = '$_id.eq.$inText';
    }
    if (inText == '') {
      customersDB =
          await _supabase.from(_table).select<List<Map<String, dynamic>>>();
    } else {
      customersDB = await _supabase
          .from(_table)
          .select<List<Map<String, dynamic>>>()
          .or(textOr);
    }
    print(customersDB.length);
    //.or('$_id.eq.$inText,$_name.eq.$inText');
    if (customersDB.isNotEmpty) {
      for (var element in customersDB) {
        mapProp = element[_properties] ?? {};
        customer = CustomerModel(
          id: element[_id],
          name: element[_name],
          country: mapProp.containsKey(CustomerModel.propCountry)
              ? element[_properties][CustomerModel.propCountry]
              : null,
          hood: mapProp.containsKey(CustomerModel.propHood)
              ? element[_properties][CustomerModel.propHood]
              : null,
          intNumber: mapProp.containsKey(CustomerModel.propIntNumber)
              ? element[_properties][CustomerModel.propIntNumber]
              : null,
          outNumber: mapProp.containsKey(CustomerModel.propOutNumber)
              ? element[_properties][CustomerModel.propOutNumber]
              : null,
          phoneNumber: mapProp.containsKey(CustomerModel.propPhoneNumber)
              ? element[_properties][CustomerModel.propPhoneNumber]
              : null,
          postalCode: mapProp.containsKey(CustomerModel.propPostalCode)
              ? element[_properties][CustomerModel.propPostalCode]
              : null,
          rfc: mapProp.containsKey(CustomerModel.propRfc)
              ? element[_properties][CustomerModel.propRfc]
              : null,
          street: mapProp.containsKey(CustomerModel.propStreet)
              ? element[_properties][CustomerModel.propStreet]
              : null,
          town: mapProp.containsKey(CustomerModel.propTown)
              ? element[_properties][CustomerModel.propTown]
              : null,
        );
        customers.add(customer);
      }
    }
    return customers;
  }
}
