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
    CustomerModel customer = CustomerModel.empty();
    //Map<String, dynamic> mapProp;
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
        //mapProp = element[_properties] ?? {};
        customer = CustomerModel(
          id: element[customer.tId],
          name: element[customer.tName],
          country: element[customer.tCountry],
          hood: element[customer.tHood],
          intNumber: element[customer.tIntNumber],
          outNumber: element[customer.tOutNumbre],
          phoneNumber: element[customer.tPhoneNumber],
          postalCode: element[customer.tPostalCode],
          rfc: element[customer.tRfc],
          street: element[customer.tStreet],
          town: element[customer.tTown],
        );
        customers.add(customer);
      }
    }
    return customers;
  }

  Future<List<CustomerModel>> fetchCustomersIlike(String inText) async {
    List<Map<String, dynamic>> customersDB = [];
    List<CustomerModel> customers = [];
    CustomerModel customer = CustomerModel.empty();
    //Map<String, dynamic> mapProp;
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
    //.or('$_id.eq.$inText,$_name.eq.$inText');
    if (customersDB.isNotEmpty) {
      for (var element in customersDB) {
        //mapProp = element[_properties] ?? {};
        customer = CustomerModel(
          id: element[customer.tId],
          name: element[customer.tName],
          country: element[customer.tCountry],
          hood: element[customer.tHood],
          intNumber: element[customer.tIntNumber],
          outNumber: element[customer.tOutNumbre],
          phoneNumber: element[customer.tPhoneNumber],
          postalCode: element[customer.tPostalCode],
          rfc: element[customer.tRfc],
          street: element[customer.tStreet],
          town: element[customer.tTown],
        );
        customers.add(customer);
      }
    }
    return customers;
  }
}
