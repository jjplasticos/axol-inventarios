import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/customer_model.dart';
import '../../repository/customer_repo.dart';
import 'customer_delete_state.dart';

class CustomerDialogDeleteCubit extends Cubit<CustomerDeleteState> {
  CustomerDialogDeleteCubit() : super(InitialCustomerDeleteState());

  Future<void> deleteCustomer(CustomerModel customer) async {
    try {
      emit(InitialCustomerDeleteState());
      emit(LoadingCustomerDeleteState());
      
      emit(LoadedCustomerDeleteState());
    } catch (e) {
      emit(InitialCustomerDeleteState());
      emit(ErrorCustomerDeleteState(error: e.toString()));
    }
    CustomerRepo().delete(customer);
  }
}