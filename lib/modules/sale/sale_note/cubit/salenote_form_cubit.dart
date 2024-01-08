import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/validation_form_model.dart';
import '../model/saelnote_add_form_model.dart';

class SalenoteFormCubit extends Cubit<SalenoteAddFormModel> {
  SalenoteFormCubit() : super(SalenoteAddFormModel.initial());

  SalenoteAddFormModel _validCustomer(SalenoteAddFormModel salenoteForm) {
    SalenoteAddFormModel newSalenoteForm = salenoteForm;
    if (salenoteForm.customer.value == '') {
      newSalenoteForm.customer.validation =
          ValidationFormModel(isValid: false, errorMessage: 'Dato no valido');
    } else {
      newSalenoteForm.customer.validation = ValidationFormModel.trueValid();
    }
    return newSalenoteForm;
  }

  SalenoteAddFormModel _validVendor(SalenoteAddFormModel salenoteForm) {
    SalenoteAddFormModel newSalenoteForm = salenoteForm;
    if (salenoteForm.vendor.value == '') {
      newSalenoteForm.vendor.validation =
          ValidationFormModel(isValid: false, errorMessage: 'Dato no valido');
    } else {
      newSalenoteForm.vendor.validation = ValidationFormModel.trueValid();
    }
    return newSalenoteForm;
  }

  SalenoteAddFormModel _validWarehouse(SalenoteAddFormModel salenoteForm) {
    SalenoteAddFormModel newSalenoteForm = salenoteForm;
    if (salenoteForm.warehouse.value == '') {
      newSalenoteForm.warehouse.validation =
          ValidationFormModel(isValid: false, errorMessage: 'Dato no valido');
    } else {
      newSalenoteForm.warehouse.validation = ValidationFormModel.trueValid();
    }
    return newSalenoteForm;
  }

  Future<void> change(String text, int position, int elementForm) async {
    SalenoteAddFormModel salenoteForm = state;
    if (elementForm == 0) {
      salenoteForm.customer.value = text;
      salenoteForm.customer.position = position;
      salenoteForm = _validCustomer(salenoteForm);
    }
    if (elementForm == 1) {
      salenoteForm.vendor.value = text;
      salenoteForm.vendor.position = position;
      salenoteForm = _validVendor(salenoteForm);
    }
    if (elementForm == 2) {
      salenoteForm.warehouse.value = text;
      salenoteForm.warehouse.position = position;
      salenoteForm = _validWarehouse(salenoteForm);
    }
    emit(SalenoteAddFormModel.initial());
    emit(salenoteForm);
  }

  Future<void> allValidate() async {
    SalenoteAddFormModel salenoteForm = state;
    salenoteForm = _validCustomer(salenoteForm);
    salenoteForm = _validVendor(salenoteForm);
    salenoteForm = _validWarehouse(salenoteForm);
    emit(SalenoteAddFormModel.initial());
    emit(salenoteForm);
  }

  void setForm(SalenoteAddFormModel salenoteForm) {
    emit(SalenoteAddFormModel.initial());
    emit(salenoteForm);
  }
}
