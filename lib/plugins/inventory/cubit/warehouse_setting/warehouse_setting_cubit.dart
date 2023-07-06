import 'package:axol_inventarios/models/warehouse_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/textfield_model.dart';
import '../../../../models/validation_form_model.dart';
import '../../repository/warehouses_repo.dart';
import 'warehouse_setting_state.dart';

class WarehouseSettingCubit extends Cubit<WarehouseSettingState> {
  WarehouseSettingCubit() : super(InitialState());

  List<ValidationFormModel> validationChange(
      TextfieldModel textfieldId,
      TextfieldModel textfieldName,
      String? userSelected,
      List<ValidationFormModel> currentValidation,
      int elementToValidate) {
    List<ValidationFormModel> validationList = [];
    final ValidationFormModel validationTrue =
        ValidationFormModel(isValid: true, errorMessage: '');

    for (var element in currentValidation) {
      validationList.add(element);
    }

    if (elementToValidate == 0 || elementToValidate == -1) {
      if (textfieldId.text == '') {
        validationList[0] =
            ValidationFormModel(isValid: false, errorMessage: 'Dato no valido');
      } else {
        validationList[0] = validationTrue;
      }
    }

    if (elementToValidate == 1 || elementToValidate == -1) {
      if (textfieldId.text == '') {
        validationList[1] =
            ValidationFormModel(isValid: false, errorMessage: 'Dato no valido');
      } else {
        validationList[1] = validationTrue;
      }
    }

    if (elementToValidate == 2 || elementToValidate == -1) {
      if (userSelected == null) {
        validationList[2] = ValidationFormModel(
            isValid: false,
            errorMessage: 'Seleccine a un encargado de almacén');
      } else {
        validationList[2] = validationTrue;
      }
    }

    return validationList;
  }

  Future<void> initialToAdd() async {
    try {
      const TextfieldModel initTextfield =
          TextfieldModel(text: '', position: 0);
      List<ValidationFormModel> validationList = [];
      for (int i = 0; i < 3; i++) {
        validationList
            .add(ValidationFormModel(isValid: true, errorMessage: ''));
      }
      emit(InitialState());
      emit(EditState(
        userSelected: null,
        textfieldName: initTextfield,
        textfieldId: initTextfield,
        validation: validationList,
      ));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> change(
      String? userSelected,
      TextfieldModel textfieldName,
      TextfieldModel textfieldId,
      List<ValidationFormModel> currentValidation,
      int elementChange) async {
    try {
      final List<ValidationFormModel> validationList;
      emit(InitialState());
      validationList = validationChange(textfieldId, textfieldName,
          userSelected, currentValidation, elementChange);
      emit(EditState(
          validation: validationList,
          textfieldId: textfieldId,
          userSelected: userSelected,
          textfieldName: textfieldName));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> add(
      TextfieldModel textfieldId,
      TextfieldModel textfieldName,
      String? retailManager,
      List<ValidationFormModel> currentValidation) async {
    try {
      WarehouseModel? warehouseDB;
      WarehouseModel warehouse;
      final List<ValidationFormModel> validationList = validationChange(
          textfieldId, textfieldName, retailManager, currentValidation, -1);
      bool finalValidation = true;
      for (var element in validationList) {
        if (element.isValid == false) {
          finalValidation = false;
        }
      }
      emit(InitialState());
      emit(LoadingState());
      warehouseDB = await WarehousesRepo().fetchWarehouse(textfieldName.text);
      if (finalValidation == true) {
        warehouse = WarehouseModel(
          id: int.parse(textfieldId.text),
          name: textfieldName.text,
          retailManager: retailManager!,
        );
        await WarehousesRepo().insertWarehouse(warehouse);
        emit(LoadedState());
      } else {
        emit(EditState(
            textfieldId: textfieldId,
            textfieldName: textfieldName,
            userSelected: retailManager,
            validation: validationList));
      }
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> edit(WarehouseModel warehouse) async {
    try {
      emit(InitialState());
      emit(LoadingState());
      await WarehousesRepo().updateWarehouse(warehouse);
      emit(LoadedState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> remove(int id) async {
    try {
      emit(InitialState());
      emit(RemoveLoadingState());
      await WarehousesRepo().deleteWarehouse(id);
      emit(RemoveLoadedState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> openAlert(int id) async {
    try {
      emit(InitialState());
      emit(RemoveAlertState(id: id));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
