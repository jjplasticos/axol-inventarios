import 'package:axol_inventarios/models/textfield_form_model.dart';
import 'package:axol_inventarios/models/validation_form_model.dart';
import 'package:axol_inventarios/plugins/sale_note/cubit/salenote_drawer_cubit/salenote_drawer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../inventory/model/warehouse_model.dart';
import '../../../inventory/repository/warehouses_repo.dart';
import '../../model/customer_model.dart';
import '../../model/saelnote_form_model.dart';
import '../../model/vendor_model.dart';
import '../../repository/customer_repo.dart';
import '../../repository/vendor_repo.dart';

class SalenoteDrawerCubit extends Cubit<SalenoteDrawerState> {
  SalenoteDrawerCubit() : super(InitialState());

  static const String _pCustomer = SalenoteFormModel.pCustomer;
  static const String _pVendor = SalenoteFormModel.pVendor;
  static const String _pWarehouse = SalenoteFormModel.pWarehouse;
  static const String _pValidation = TextfieldFormModel.pValidation;
  static const String _pCustomerModel = SalenoteFormModel.pCustomerModel;
  static const String _pVendorModel = SalenoteFormModel.pVendorModel;
  static const String _pWarehouseModel = SalenoteFormModel.pWarehouseModel;

  SalenoteFormModel _changeSalenoteForm(List<String> response,
      Map<int, dynamic> modelMap, SalenoteFormModel currentForm) {
    SalenoteFormModel salenoteForm = currentForm;
    List elementsList;
    for (var element in response) {
      elementsList = element.split(':');
      if (elementsList.first == _pCustomer) {
        salenoteForm.customer = _changeSalenoteTextfield(
            elementsList.elementAt(1),
            currentForm.customer,
            elementsList.elementAt(2));
      } else if (elementsList.first == _pVendor) {
        salenoteForm.vendor = _changeSalenoteTextfield(
            elementsList.elementAt(1),
            currentForm.vendor,
            elementsList.elementAt(2));
      } else if (elementsList.first == _pWarehouse) {
        salenoteForm.warehouse = _changeSalenoteTextfield(
            elementsList.elementAt(1),
            currentForm.warehouse,
            elementsList.elementAt(2));
      }
    }
    return salenoteForm;
  }

  TextfieldFormModel _changeSalenoteTextfield(String elementKey,
      TextfieldFormModel currentTextField, String? response) {
    TextfieldFormModel textfieldForm = currentTextField;
    List<String> responseList = [];
    if (response != null) {
      responseList = response.split('/');
    }
    if (elementKey == TextfieldFormModel.pValidation) {
      if (responseList.first == 'true') {
        textfieldForm.validation =
            ValidationFormModel(isValid: true, errorMessage: '');
      } else if (responseList.first == 'false') {
        textfieldForm.validation = ValidationFormModel(
            isValid: false, errorMessage: responseList.last);
      }
    }
    return textfieldForm;
  }

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
                '$_pCustomer:$_pValidation:false/Hay más de un cliente con el mismo nombre');
          } else if (customersDB.length == 1) {
            response.add('$_pCustomer:$_pValidation:true/');
            response.add(_pCustomerModel);
            modelMap[0] = customersDB.first;
          }
        } else {
          response.add('$_pCustomer:$_pValidation:false/Dato inexistente');
        }
        if (vendorsDB.isNotEmpty) {
          if (vendorsDB.length > 1) {
            response.add(
                '$_pVendor:$_pValidation:false/Hay más de un vendedor con el mismo nombre');
          } else if (vendorsDB.length == 1) {
            response.add('$_pVendor:$_pValidation:true/');
            response.add(_pVendorModel);
            modelMap[1] = vendorsDB.first;
          }
        } else {
          response.add('$_pVendor:$_pValidation:false/Dato inexistente');
        }
        if (warehouseDB.isNotEmpty) {
          if (warehouseDB.length > 1) {
            response.add(
                '$_pWarehouse:$_pValidation:false/Hay más de un almacén con el mismo nombre');
          } else if (warehouseDB.length == 1) {
            response.add('$_pWarehouse:$_pValidation:true/');
            response.add(_pWarehouseModel);
            modelMap[2] = warehouseDB.first;
          }
        } else {
          response.add('$_pWarehouse:$_pValidation:false/Dato inexistente');
        }
      } else if (keyElement == 0) {
        //validar Customer
        customersDB =
            await CustomerRepo().fetchCustomersEq(salenoteForm.customer.value);
        if (customersDB.isNotEmpty) {
          if (customersDB.length > 1) {
            response.add(
                '$_pCustomer:$_pValidation:false/Hay más de un cliente con el mismo nombre');
          } else if (customersDB.length == 1) {
            response.add('$_pCustomer:$_pValidation:true/');
            response.add(_pCustomerModel);
            modelMap[0] = customersDB.first;
          }
        } else {
          response.add('$_pCustomer:$_pValidation:false/Dato inexistente');
        }
      } else if (keyElement == 1) {
        //Validar Vendor
        vendorsDB = await VendorRepo().fetchVendorEq(salenoteForm.vendor.value);
        if (vendorsDB.isNotEmpty) {
          if (vendorsDB.length > 1) {
            response.add(
                '$_pVendor:$_pValidation:false/Hay más de un vendedor con el mismo nombre');
          } else if (vendorsDB.length == 1) {
            response.add('$_pVendor:$_pValidation:true/');
            response.add(_pVendorModel);
            modelMap[1] = vendorsDB.first;
          }
        } else {
          response.add('$_pVendor:$_pValidation:false/Dato inexistente');
        }
      } else if (keyElement == 2) {
        //valdiar Warehouse
        warehouseDB = await WarehousesRepo()
            .fetchWarehouseEq(salenoteForm.warehouse.value);
        if (warehouseDB.isNotEmpty) {
          if (warehouseDB.length > 1) {
            response.add(
                '$_pWarehouse:$_pValidation:false/Hay más de un almacén con el mismo nombre');
          } else if (warehouseDB.length == 1) {
            response.add('$_pWarehouse:$_pValidation:true/');
            response.add(_pWarehouseModel);
            modelMap[2] = warehouseDB.first;
          }
        } else {
          response.add('$_pWarehouse:$_pValidation:false/Dato inexistente');
        }
      }
      emit(InitialState());
      emit(LoadedState(response: response, modelMap: modelMap));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
