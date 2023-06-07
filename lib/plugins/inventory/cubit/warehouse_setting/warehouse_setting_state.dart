import 'package:equatable/equatable.dart';

abstract class WarehouseSettingState extends Equatable {
  const WarehouseSettingState();
}

class InitialState extends WarehouseSettingState {
  @override
  List<Object?> get props => [];
}

class EditState extends WarehouseSettingState {
  final String? userSelected;
  final String currentName;
  final bool? error;
  final String? message;
  const EditState(
      {required this.userSelected,
      required this.currentName,
      this.error,
      this.message});
  @override
  List<Object?> get props => [userSelected, currentName, error, message];
}

class LoadingState extends WarehouseSettingState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends WarehouseSettingState {
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
