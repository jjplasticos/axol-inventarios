import 'package:axol_inventarios/plugins/inventory_/inventory/model/warehouse_model.dart';
import 'package:axol_inventarios/plugins/sale/sale_note/model/vendor_model.dart';
import 'package:axol_inventarios/plugins/sale/customer/repository/customer_repo.dart';
import 'package:axol_inventarios/plugins/sale/sale_note/repository/vendor_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../customer/model/customer_model.dart';
import 'drawer_search_state.dart';

class DrawerSearchCubit extends Cubit<DrawerSearchState> {
  DrawerSearchCubit() : super(InitialState());

  Future<void> loadCustomers(String finder) async {
    try {
      emit(InitialState());
      emit(LoadingState());
      List<CustomerModel> customersDB;
      customersDB = await CustomerRepo().fetchCustomersIlike(finder);
      emit(LoadedState(listData: customersDB));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
