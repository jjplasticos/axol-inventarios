import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/saelnote_add_form_model.dart';

class SaleNoteAddForm extends Cubit<SaleNoteAddFormModel>{
  SaleNoteAddForm() : super(SaleNoteAddFormModel.empty());

  void setForm(SaleNoteAddFormModel form) {
    emit(SaleNoteAddFormModel.empty());
    emit(form);
  }
}