import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/vendor_model.dart';

class VendorRepo {
  static const String _table = 'vendors';
  final String _id = VendorModel.empty().tId;
  final String _name = VendorModel.empty().tName;
  final _supabase = Supabase.instance.client;

  Future<List<VendorModel>> fetchVendorEq(String inText) async {
    List<Map<String, dynamic>> vendorsDB = [];
    List<VendorModel> vendors = [];
    VendorModel vendor;
    String textOr;
    if (int.tryParse(inText) == null) {
      textOr = '$_name.eq.$inText';
    } else {
      textOr = '$_id.eq.$inText';
    }
    vendorsDB = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .or(textOr);
    if (vendorsDB.isNotEmpty) {
      for (var element in vendorsDB) {
        vendor = VendorModel(
          id: element[_id],
          name: element[_name],
        );
        vendors.add(vendor);
      }
    }
    return vendors;
  }

  Future<List<VendorModel>> fetchVendorIlike(String inText) async {
    List<Map<String, dynamic>> vendorsDB = [];
    List<VendorModel> vendors = [];
    VendorModel vendor;
    String textOr;
    if (inText == '') {
      vendorsDB =
          await _supabase.from(_table).select<List<Map<String, dynamic>>>();
    } else {
      if (int.tryParse(inText) == null) {
        textOr = '$_name.ilike.%$inText%';
      } else {
        textOr = '$_id.eq.$inText';
      }
      vendorsDB = await _supabase
          .from(_table)
          .select<List<Map<String, dynamic>>>()
          .or(textOr);
    }

    if (vendorsDB.isNotEmpty) {
      for (var element in vendorsDB) {
        vendor = VendorModel(
          id: element[_id],
          name: element[_name],
        );
        vendors.add(vendor);
      }
    }
    return vendors;
  }

  Future<int> fetchAvailableId() async {
    List<Map<String, dynamic>> vendorIdDB = [];
    List<int> listId = [];
    int newId = -1;
    vendorIdDB =
        await _supabase.from(_table).select<List<Map<String, dynamic>>>(_id);
    for (var element in vendorIdDB) {
      listId.add(int.parse(element[_id].toString()));
    }
    listId.sort((a, b) => a.compareTo(b));
    for (int i = 0; i <= listId.length; i++) {
      if (listId.contains(i) == false) {
        listId.add(i);
        newId = i;
        i = listId.length + 1;
      }
    }
    return newId;
  }


  Future<bool> existId(int id) async {
    List<Map<String, dynamic>> vendorsDB = [];
    bool exist;
    vendorsDB = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .eq(_id, id);
    if (vendorsDB.isEmpty && id >= 0) {
      exist = false;
    } else {
      exist = true;
    }
    return exist;
  }

  Future<void> insert(VendorModel vendor) async {
    await _supabase.from(_table).insert({
      _id: vendor.id,
      _name: vendor.name,
    });
  }

  Future<void> delete(VendorModel vendor) async {
    await _supabase.from(_table).delete().eq(_id, vendor.id);
  }
}
