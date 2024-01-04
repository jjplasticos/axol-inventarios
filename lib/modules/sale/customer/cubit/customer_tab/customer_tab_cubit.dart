import 'package:axol_inventarios/modules/sale/customer/model/customer_model.dart';
import 'package:axol_inventarios/modules/sale/customer/repository/customer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'customer_tab_state.dart';

class CustomerTabCubit extends Cubit<CustomerTabState> {
  CustomerTabCubit() : super(InitialCustomerTabState());

  Future<void> load(String find) async {
    List<CustomerModel> customerListDB;
    try {
      emit(InitialCustomerTabState());
      emit(LoadingCustomerTabState());
      customerListDB = await CustomerRepo().fetchCustomersIlike(find);
      emit(LoadedCustomerTabState(customerList: customerListDB));
    } catch (e) {
      emit(InitialCustomerTabState());
      emit(ErrorCustomerTabState(error: e.toString()));
    }
  }

  Future<void> deleteCustomer(CustomerModel customer) async {
    CustomerRepo().delete(customer);
  }
}