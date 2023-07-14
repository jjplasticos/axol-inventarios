import 'dart:js';

import 'package:axol_inventarios/plugins/sale_note/cubit/salenote_drawer_cubit/salenote_drawer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/warehouse_model.dart';
import '../../model/customer_model.dart';
import '../../model/saelnote_form_model.dart';
import '../../model/vendor_model.dart';
import '../../repository/customer_repo.dart';

class SalenoteDrawerCubit extends Cubit<SalenoteDrawerState> {
  SalenoteDrawerCubit() : super(InitialState());

  Future<void> change(SalenoteFormModel salenoteForm, int keyElement) async {
    try {
      List<CustomerModel> customersDB;
      List<VendorModel> vendorsDB;
      List<WarehouseModel> warehouseDB;
      String response = '';
      emit(const LoadingState());
      if (keyElement == -1) {
        //Validar todos
      } else if (keyElement == 0) {
        //validar Customer
        customersDB =
            await CustomerRepo().fetchCustomersEq(salenoteForm.customer.value);
        if (customersDB.isNotEmpty) {
          if (customersDB.length > 1) {
            response =
                'edit:validation:false/Hay más de un cliente con el mismo nombre';
          } else if (customersDB.length == 1) {
            response = 'edit:validation:true/';
          }
        }
      } else if (keyElement == 1) {
        //Validar Vendor
        customersDB =
            await CustomerRepo().fetchCustomersEq(salenoteForm.vendor.value);
      } else if (keyElement == 2) {
        //valdiar Warehouse
        customersDB =
            await CustomerRepo().fetchCustomersEq(salenoteForm.warehouse.value);
      }
      emit(InitialState());
      emit(LoadedState(response: response, modelMap: {}));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
