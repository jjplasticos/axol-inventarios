import 'package:axol_inventarios/models/textfield_form_model.dart';
import 'package:axol_inventarios/plugins/sale_note/cubit/salenote_drawer_cubit/salenote_drawer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../inventory/model/warehouse_model.dart';
import '../../../inventory/repository/warehouses_repo.dart';
import '../../model/customer_model.dart';
import '../../model/saelnote_form_model.dart';
import '../../model/vendor_model.dart';
import '../../repository/customer_repo.dart';
import '../../repository/vendor_repo.dart';

class SalenoteDrawerCubit extends Cubit<SalenoteDrawerState> {
  SalenoteDrawerCubit() : super(InitialState());

  Future<void> initial() async {
    try {
      emit(InitialState());
      emit(LoadingState());
      emit(LoadedState(modelMap: {}, response: []));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> change(SalenoteFormModel salenoteForm, int keyElement) async {
    try {
      const String pCustomer = SalenoteFormModel.pCustomer;
      const String pVendor = SalenoteFormModel.pVendor;
      const String pWarehouse = SalenoteFormModel.pWarehouse;
      const String pValidation = TextfieldFormModel.pValidation;
      const String pCustomerModel = SalenoteFormModel.pCustomerModel;
      const String pVendorModel = SalenoteFormModel.pVendorModel;
      const String pWarehouseModel = SalenoteFormModel.pWarehouseModel;

      List<CustomerModel> customersDB;
      List<VendorModel> vendorsDB;
      List<WarehouseModel> warehouseDB;
      List<String> response = [];
      Map<int, dynamic> modelMap = {
        0: CustomerModel.empty(),
        1: VendorModel.empty(),
        2: WarehouseModel.empty(),
      };
      emit(const LoadingState());
      if (keyElement == -1) {
        //Validar todos
        customersDB =
            await CustomerRepo().fetchCustomersEq(salenoteForm.customer.value);
        vendorsDB = await VendorRepo().fetchVendorEq(salenoteForm.vendor.value);
        warehouseDB = await WarehousesRepo()
            .fetchWarehouseEq(salenoteForm.warehouse.value);
        if (customersDB.isNotEmpty) {
          if (customersDB.length > 1) {
            response.add(
                '$pCustomer:$pValidation:false/Hay más de un cliente con el mismo nombre');
          } else if (customersDB.length == 1) {
            response.add('$pCustomer:$pValidation:true/');
            response.add(pCustomerModel);
            modelMap[0] = customersDB.first;
          }
        } else {
          response.add('$pCustomer:$pValidation:false/Dato inexistente');
        }
        if (vendorsDB.isNotEmpty) {
          if (vendorsDB.length > 1) {
            response.add(
                '$pVendor:$pValidation:false/Hay más de un vendedor con el mismo nombre');
          } else if (vendorsDB.length == 1) {
            response.add('$pVendor:$pValidation:true/');
            response.add(pVendorModel);
            modelMap[1] = vendorsDB.first;
          }
        } else {
          response.add('$pVendor:$pValidation:false/Dato inexistente');
        }
        if (warehouseDB.isNotEmpty) {
          if (warehouseDB.length > 1) {
            response.add(
                '$pWarehouse:$pValidation:false/Hay más de un almacén con el mismo nombre');
          } else if (warehouseDB.length == 1) {
            response.add('$pWarehouse:$pValidation:true/');
            response.add(pWarehouseModel);
            modelMap[2] = warehouseDB.first;
          }
        } else {
          response.add('$pWarehouse:$pValidation:false/Dato inexistente');
        }
      } else if (keyElement == 0) {
        //validar Customer
        customersDB =
            await CustomerRepo().fetchCustomersEq(salenoteForm.customer.value);
        if (customersDB.isNotEmpty) {
          if (customersDB.length > 1) {
            response.add(
                '$pCustomer:$pValidation:false/Hay más de un cliente con el mismo nombre');
          } else if (customersDB.length == 1) {
            response.add('$pCustomer:$pValidation:true/');
            response.add(pCustomerModel);
            modelMap[0] = customersDB.first;
          }
        } else {
          response.add('$pCustomer:$pValidation:false/Dato inexistente');
        }
      } else if (keyElement == 1) {
        //Validar Vendor
        vendorsDB = await VendorRepo().fetchVendorEq(salenoteForm.vendor.value);
        if (vendorsDB.isNotEmpty) {
          if (vendorsDB.length > 1) {
            response.add(
                '$pVendor:$pValidation:false/Hay más de un vendedor con el mismo nombre');
          } else if (vendorsDB.length == 1) {
            response.add('$pVendor:$pValidation:true/');
            response.add(pVendorModel);
            modelMap[1] = vendorsDB.first;
          }
        } else {
          response.add('$pVendor:$pValidation:false/Dato inexistente');
        }
      } else if (keyElement == 2) {
        //valdiar Warehouse
        warehouseDB = await WarehousesRepo()
            .fetchWarehouseEq(salenoteForm.warehouse.value);
        if (warehouseDB.isNotEmpty) {
          if (warehouseDB.length > 1) {
            response.add(
                '$pWarehouse:$pValidation:false/Hay más de un almacén con el mismo nombre');
          } else if (warehouseDB.length == 1) {
            response.add('$pWarehouse:$pValidation:true/');
            response.add(pWarehouseModel);
            modelMap[2] = warehouseDB.first;
          }
        } else {
          response.add('$pWarehouse:$pValidation:false/Dato inexistente');
        }
      }
      emit(InitialState());
      emit(LoadedState(response: response, modelMap: modelMap));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
