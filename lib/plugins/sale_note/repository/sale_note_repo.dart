import 'package:axol_inventarios/plugins/sale_note/model/customer_model.dart';
import 'package:axol_inventarios/plugins/sale_note/model/vendor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../models/warehouse_model.dart';
import '../model/sale_note_mdoel.dart';
import '../model/salenote_filter_model.dart';

class SaleNoteRepo {
  static const String _table = 'sales_notes';
  final _supabase = Supabase.instance.client;

  Future<List<SaleNoteModel>> fetchNotes(
      SaleNoteFilterModel filter, String finder) async {
    List<SaleNoteModel> salesNotes = [];
    SaleNoteModel saleNote;
    List<Map<String, dynamic>> saleNoteDB = [];
    Map<String, dynamic> filters = {};

    if (filter.customer > -1) {
      filters['${SaleNoteModel.propCustomer}->>${CustomerModel.propId}'] =
          filter.customer;
    }
    if (filter.vendor != -1) {
      filters['${SaleNoteModel.propVendor}->>${VendorModel.propId}'] =
          filter.vendor;
    }
    if (filter.warehouse != -1) {
      filters['${SaleNoteModel.propWarehouse}->>${WarehouseModel.propId}'] =
          filter.warehouse;
    }

    //await _supabase.from(_table).select().filter(column, operator, value)

    return salesNotes;
  }
}
