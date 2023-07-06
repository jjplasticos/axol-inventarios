import 'package:axol_inventarios/models/validation_form_model.dart';
import 'package:axol_inventarios/plugins/inventory/cubit/textfield_finder_invrow_cubit.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/textfield_model.dart';

abstract class WarehouseSettingState extends Equatable {
  const WarehouseSettingState();
}

class InitialState extends WarehouseSettingState {
  @override
  List<Object?> get props => [];
}

class EditState extends WarehouseSettingState {
  final TextfieldModel textfieldId;
  final String? userSelected;
  final TextfieldModel textfieldName;
  final List<ValidationFormModel> validation;
  const EditState({
    required this.userSelected,
    required this.textfieldName,
    required this.textfieldId,
    required this.validation,
  });
  @override
  List<Object?> get props =>
      [userSelected, textfieldName, textfieldId, validation];
}

class LoadingState extends WarehouseSettingState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends WarehouseSettingState {
  @override
  List<Object?> get props => [];
}

class RemoveAlertState extends WarehouseSettingState {
  int id;
  RemoveAlertState({required this.id});
  @override
  List<Object?> get props => [id];
}

class RemoveLoadingState extends WarehouseSettingState {
  @override
  List<Object?> get props => [];
}

class RemoveLoadedState extends WarehouseSettingState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends WarehouseSettingState {
  final String error;

  const ErrorState({required this.error});

  @override
  String toString() => 'Error: $error';

  @override
  List<Object?> get props => [error];
}
