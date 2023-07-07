import 'package:axol_inventarios/models/validation_form_model.dart';
import 'package:axol_inventarios/models/warehouse_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/textfield_model.dart';
import '../model/warehouse_stream_model.dart';

class TransferCubit extends Cubit<WarehouseStreamModel> {
  TransferCubit() : super(WarehouseStreamModel.initial());

  Future<void> initial() async {
    emit(WarehouseStreamModel.initial());
    final WarehouseStreamModel warehouseStream = WarehouseStreamModel(
      dropdownManager: WHDropdownModel.initial(),
      textfieldId: WHTextfieldModel.initial(),
      textfieldName: WHTextfieldModel.initial(),
    );
    emit(warehouseStream);
  }

  Future<void> changeTextfield(TextfieldModel textfield, int elementForm) async {
    WarehouseStreamModel warehouseStream = state;
    
    if (elementForm == 0) {
      if (textfield.text == '') {
        warehouseStream.textfieldId.text;
        //seguir aqui
      }
    }
  }
}
