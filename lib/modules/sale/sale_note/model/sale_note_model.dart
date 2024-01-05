import '../../../inventory_/inventory/model/warehouse_model.dart';
import '../../customer/model/customer_model.dart';
import 'sale_product_model.dart';
import '../../vendor/model/vendor_model.dart';

class SaleNoteModel {
  final int id;
  final CustomerModel customer;
  final int status;
  final DateTime date;
  final double? subtotal;
  final double? iva;
  final double total;
  final WarehouseModel warehouse;
  final VendorModel vendor;
  final int type;
  final String note;
  final SaleProductModel saleProduct;

  static const String propId = 'id';
  static const String propCustomer = 'customer';
  static const String propStatus = 'status';
  static const String propDate = 'date';
  static const String propSubtotal = 'subtotal';
  static const String propIva = 'iva';
  static const String propTotal = 'total';
  static const String propWarehouse = 'warehouse';
  static const String propVendor = 'vendor';
  static const String propType = 'type';
  static const String propNote = 'note';
  static const String propSaleProduct = 'products';

  SaleNoteModel({
    required this.id,
    required this.customer,
    required this.status,
    required this.date,
    this.subtotal,
    this.iva,
    required this.total,
    required this.warehouse,
    required this.vendor,
    required this.type,
    required this.note,
    required this.saleProduct,
  });
}
