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

  Future<void> changeTextfield(
      TextfieldModel textfield, int elementForm) async {
    WarehouseStreamModel warehouseStream = state;
    if (elementForm == 0) {
      warehouseStream.textfieldId.text = textfield.text;
      warehouseStream.textfieldId.position = textfield.position;
      if (textfield.text == '') {
        warehouseStream.textfieldId.validation =
            ValidationFormModel(isValid: false, errorMessage: 'Dato no valido');
      } else {
        warehouseStream.textfieldId.validation =
            ValidationFormModel.trueValid();
      }
    }
    if (elementForm == 1) {
      warehouseStream.textfieldName.text = textfield.text;
      warehouseStream.textfieldName.position = textfield.position;
      if (textfield.text == '') {
        warehouseStream.textfieldName.validation =
            ValidationFormModel(isValid: false, errorMessage: 'Dato no valido');
      } else {
        warehouseStream.textfieldName.validation =
            ValidationFormModel.trueValid();
      }
    }
  }

  Future<void> changeDropdown(String value) async {
    WarehouseStreamModel warehouseStream = state;
    warehouseStream.dropdownManager.value = value;
    if (value == '') {
      warehouseStream.dropdownManager.validation = ValidationFormModel(
          isValid: false, errorMessage: 'Selecione a un encargado de almacén');
    } else {
      warehouseStream.dropdownManager.validation =
          ValidationFormModel.trueValid();
    }
  }

  Future<void> 
}
