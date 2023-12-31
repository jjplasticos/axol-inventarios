import 'package:axol_inventarios/plugins/sale_note/model/sale_note_model.dart';

class SaleNoteFilterModel {
  //final String product;
  //final int saleNote;
  final int customer;
  final int vendor;
  final int warehouse;
  final DateTime startTime;
  final DateTime endTime;
  final int limit;

  /*static const String propProduct = 'products';
  static const String propSaleNote = 'saleNote';
  static const String propCustomer = 'customer';
  static const String propVendor = 'vendor';
  static const String propWarehouse = 'warehouse';
  static const String propDate = 'date';*/

  SaleNoteFilterModel({
    //required this.saleNote,
    //required this.product,
    required this.customer,
    required this.vendor,
    required this.warehouse,
    required this.startTime,
    required this.endTime,
    required this.limit,
  });

  static SaleNoteFilterModel empty() => SaleNoteFilterModel(
        customer: -1,
        vendor: -1,
        warehouse: -1,
        limit: 0,
        startTime: DateTime.fromMillisecondsSinceEpoch(0),
        endTime: DateTime.fromMillisecondsSinceEpoch(32503708800000),
      );
}
