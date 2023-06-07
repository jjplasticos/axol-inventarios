import 'package:axol_inventarios/models/warehouse_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/user_mdoel.dart';

abstract class WarehousesLoadState extends Equatable {
  const WarehousesLoadState();
}

class InitialState extends WarehousesLoadState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends WarehousesLoadState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends WarehousesLoadState {
  final List<WarehouseModel> warehouses;
  final List<UserModel> users;

  const LoadedState({required this.warehouses, required this.users});

  @override
  List<Object?> get props => [warehouses, users];
}

class ErrorState extends WarehousesLoadState {
  final String error;

  const ErrorState({required this.error});

  @override
  String toString() => 'Error: $error';

  @override
  List<Object?> get props => [error];
}
