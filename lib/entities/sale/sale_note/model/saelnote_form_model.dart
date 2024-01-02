import 'package:axol_inventarios/entities/sale/sale_note/model/vendor_model.dart';

import '../../../../models/textfield_form_model.dart';
import '../../../inventory_/inventory/model/warehouse_model.dart';
import '../../customer/model/customer_model.dart';

class SalenoteFormModel {
  TextfieldFormModel customer;
  TextfieldFormModel vendor;
  TextfieldFormModel warehouse;
  CustomerModel customerModel;
  VendorModel vendorModel;
  WarehouseModel warehouseModel;

  SalenoteFormModel({
    required this.customer,
    required this.vendor,
    required this.warehouse,
    required this.customerModel,
    required this.vendorModel,
    required this.warehouseModel,
  });

  static SalenoteFormModel initial() => SalenoteFormModel(
        customer: TextfieldFormModel.empty(),
        vendor: TextfieldFormModel.empty(),
        warehouse: TextfieldFormModel.empty(),
        customerModel: CustomerModel.empty(),
        vendorModel: VendorModel.empty(),
        warehouseModel: WarehouseModel.empty(),
      );

  static const String pCustomer = 'customer';
  static const String pVendor = 'vendor';
  static const String pWarehouse = 'warehouse';
  static const String pCustomerModel = 'customerModel';
  static const String pVendorModel = 'vendorModel';
  static const String pWarehouseModel = 'warehouseModel';
}
