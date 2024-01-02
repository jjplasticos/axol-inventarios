import 'package:axol_inventarios/modules/sale/customer/model/customer_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerRepo {
  final String _table = 'customers';
  final String _id = CustomerModel.empty().tId;
  final String _name = CustomerModel.empty().tName;
  final String _rfc = CustomerModel.empty().tRfc;
  final String _street = CustomerModel.empty().tStreet;
  final String _outNumber = CustomerModel.empty().tOutNumbre;
  final String _intNumber = CustomerModel.empty().tIntNumber;
  final String _hood = CustomerModel.empty().tHood;
  final String _postalCode = CustomerModel.empty().tPostalCode;
  final String _town = CustomerModel.empty().tTown;
  final String _country = CustomerModel.empty().tCountry;
  final String _phoneNumber = CustomerModel.empty().tPhoneNumber;

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

  Future<int> fetchAvailableId() async {
    List<Map<String, dynamic>> customerIdDB = [];
    List<int> listId = [];
    int newId = -1;
    customerIdDB =
        await _supabase.from(_table).select<List<Map<String, dynamic>>>(_id);
    for (var element in customerIdDB) {
      listId.add(int.parse(element[_id].toString()));
    }
    listId.sort((a, b) => a.compareTo(b));
    for (int i = 1; i <= listId.length; i++) {
      if (listId.contains(i) == false) {
        listId.add(i);
        newId = i;
        i = listId.length + 1;
      }
    }
    return newId;
  }


  Future<bool> existId(int id) async {
    List<Map<String, dynamic>> customersDB = [];
    bool exist;
    customersDB = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .eq(_id, id);
    if (customersDB.isEmpty) {
      exist = false;
    } else {
      exist = true;
    }
    return exist;
  }

  Future<void> insertCustomer(CustomerModel customer) async {
    await _supabase.from(_table).insert({
      _id: customer.id,
      _name: customer.name,
      _phoneNumber: customer.phoneNumber,
      _country: customer.country,
      _hood: customer.hood,
      _intNumber: customer.intNumber,
      _outNumber: customer.outNumber,
      _postalCode: customer.postalCode,
      _rfc: customer.rfc,
      _street: customer.street,
      _town: customer.town,
    });
  }
}
