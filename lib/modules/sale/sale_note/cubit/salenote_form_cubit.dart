import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/validation_form_model.dart';
import '../model/saelnote_add_form_model.dart';

class SalenoteFormCubit extends Cubit<SaleNoteAddFormModel> {
  SalenoteFormCubit() : super(SaleNoteAddFormModel.empty());

  SaleNoteAddFormModel _validCustomer(SaleNoteAddFormModel salenoteForm) {
    SaleNoteAddFormModel newSalenoteForm = salenoteForm;
    if (salenoteForm.customer.value == '') {
      newSalenoteForm.customer.validation =
          ValidationFormModel(isValid: false, errorMessage: 'Dato no valido');
    } else {
      newSalenoteForm.customer.validation = ValidationFormModel.trueValid();
    }
    return newSalenoteForm;
  }

  SaleNoteAddFormModel _validVendor(SaleNoteAddFormModel salenoteForm) {
    SaleNoteAddFormModel newSalenoteForm = salenoteForm;
    if (salenoteForm.vendor.value == '') {
      newSalenoteForm.vendor.validation =
          ValidationFormModel(isValid: false, errorMessage: 'Dato no valido');
    } else {
      newSalenoteForm.vendor.validation = ValidationFormModel.trueValid();
    }
    return newSalenoteForm;
  }

  SaleNoteAddFormModel _validWarehouse(SaleNoteAddFormModel salenoteForm) {
    SaleNoteAddFormModel newSalenoteForm = salenoteForm;
    if (salenoteForm.warehouse.value == '') {
      newSalenoteForm.warehouse.validation =
          ValidationFormModel(isValid: false, errorMessage: 'Dato no valido');
    } else {
      newSalenoteForm.warehouse.validation = ValidationFormModel.trueValid();
    }
    return newSalenoteForm;
  }

  Future<void> change(String text, int position, int elementForm) async {
    SaleNoteAddFormModel salenoteForm = state;
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
    emit(SaleNoteAddFormModel.empty());
    emit(salenoteForm);
  }

  Future<void> allValidate() async {
    SaleNoteAddFormModel salenoteForm = state;
    salenoteForm = _validCustomer(salenoteForm);
    salenoteForm = _validVendor(salenoteForm);
    salenoteForm = _validWarehouse(salenoteForm);
    emit(SaleNoteAddFormModel.empty());
    emit(salenoteForm);
  }

  void setForm(SaleNoteAddFormModel salenoteForm) {
    emit(SaleNoteAddFormModel.empty());
    emit(salenoteForm);
  }
}
