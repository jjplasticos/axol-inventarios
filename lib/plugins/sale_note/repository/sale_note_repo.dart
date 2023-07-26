import 'package:axol_inventarios/plugins/sale_note/model/customer_model.dart';
import 'package:axol_inventarios/plugins/sale_note/model/sale_product_model.dart';
import 'package:axol_inventarios/plugins/sale_note/model/vendor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../inventory_/inventory/model/warehouse_model.dart';
import '../model/sale_note_mdoel.dart';
import '../model/salenote_filter_model.dart';

class SaleNoteRepo {
  static const String _table = 'sales_notes';
  static const String _id = 'id';
  static const String _customer = 'customer';
  static const String _status = 'status';
  static const String _time = 'date';
  static const String _subtotal = 'subtotal';
  static const String _iva = 'iva';
  static const String _total = 'total';
  static const String _warehouse = 'warehouse';
  static const String _vendor = 'vendor';
  static const String _type = 'type';
  static const String _note = 'note';
  static const String _products = 'products';
  final _supabase = Supabase.instance.client;

  Future<List<SaleNoteModel>> fetchNotes(
      SaleNoteFilterModel filter, String finder) async {
    List<SaleNoteModel> salesNotes = [];
    SaleNoteModel saleNote;
    List<Map<String, dynamic>> saleNoteDB = [];
    Map<String, dynamic> filters = {};
    String textOr;
    int filterStartDate = 0;
    int filterEndDate = 32503708800000;

    if (filter.customer > -1) {
      filters['${SaleNoteModel.propCustomer}->>${CustomerModel.propId}'] =
          filter.customer;
    }
    if (filter.vendor > -1) {
      filters['${SaleNoteModel.propVendor}->>${VendorModel.propId}'] =
          filter.vendor;
    }
    if (filter.warehouse > -1) {
      filters['${SaleNoteModel.propWarehouse}->>${WarehouseModel.propId}'] =
          filter.warehouse;
    }

    if (finder == '') {
      saleNoteDB =
          await _supabase.from(_table).select<List<Map<String, dynamic>>>();
      /*.match(filters)
          .lte(_time, filterEndDate)
          .gte(_time, filterStartDate);*/
    } else {
      textOr =
          '${SaleNoteModel.propCustomer}->>${CustomerModel.propName}.ilike.%$finder%,';
      textOr =
          '$textOr${SaleNoteModel.propVendor}->>${VendorModel.propName}.ilike.%$finder%';
      if (double.tryParse(finder) != null) {
        textOr = '$textOr,$_id.eq.$finder';
      }
      saleNoteDB = await _supabase
          .from(_table)
          .select<List<Map<String, dynamic>>>()
          .or(textOr);
    }
    for (var element in saleNoteDB) {
      saleNote = SaleNoteModel(
        id: element[_id],
        customer: CustomerModel.fillMap(element[_customer]),
        status: element[_status],
        date: DateTime.fromMillisecondsSinceEpoch(element[_time]),
        total: element[_total],
        warehouse: WarehouseModel.fillMap(element[_warehouse]),
        vendor: VendorModel.fillMap(element[_vendor]),
        type: element[_type],
        note: element[_note],
        saleProduct: SaleProductModel.empty(),
      );
      salesNotes.add(saleNote);
    }

    return salesNotes;
  }
}
