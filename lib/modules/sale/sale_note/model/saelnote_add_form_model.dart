import 'package:axol_inventarios/modules/sale/vendor/model/vendor_model.dart';

import '../../../../models/textfield_form_model.dart';
import '../../../inventory_/inventory/model/warehouse_model.dart';
import '../../customer/model/customer_model.dart';
import 'salenote_row_form_model.dart';

class SalenoteAddFormModel {
  TextfieldFormModel customer;
  TextfieldFormModel vendor;
  TextfieldFormModel warehouse;
  List<SaleNoteRowFormModel> content;

  SalenoteAddFormModel({
    required this.customer,
    required this.vendor,
    required this.warehouse,
    required this.content,
  });

  SalenoteAddFormModel.empty()
      : customer = TextfieldFormModel.empty(),
        vendor = TextfieldFormModel.empty(),
        warehouse = TextfieldFormModel.empty(),
        content = [];

  static const String pCustomer = 'customer';
  static const String pVendor = 'vendor';
  static const String pWarehouse = 'warehouse';
  static const String pCustomerModel = 'customerModel';
  static const String pVendorModel = 'vendorModel';
  static const String pWarehouseModel = 'warehouseModel';
}
