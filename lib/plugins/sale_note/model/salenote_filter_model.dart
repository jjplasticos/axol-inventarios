class SaleNoteFilterModel {
  final String product;
  final int saleNote;
  final int customer;
  final int vendor;
  final int warehouse;
  final DateTime startTime;
  final DateTime endTime;
  final int limit;

  static const String propProduct = 'products';
  static const String propSaleNoteId = 'id';
  static const String propCustomer = 'customer';
  static const String propVendor = 'vendor';
  static const String propWarehouse = 'warehouse';
  static const String propDate = 'date';

  SaleNoteFilterModel({
    required this.saleNote,
    required this.product,
    required this.customer,
    required this.vendor,
    required this.warehouse,
    required this.startTime,
    required this.endTime,
    required this.limit,
  });
}
