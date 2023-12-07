import 'package:equatable/equatable.dart';

import '../../model/inventory_move/inventory_move_model.dart';
import '../../../../../models/user_mdoel.dart';

abstract class InventoryMovesState extends Equatable {
  const InventoryMovesState();
}

class EditInitialState extends InventoryMovesState {
  @override
  List<Object?> get props => [];
}

class EditState extends InventoryMovesState {
  final InventoryMoveModel inventoryMoveElements;
  const EditState({required this.inventoryMoveElements});
  @override
  List<Object?> get props => [inventoryMoveElements];
}

class SaveInitialState extends InventoryMovesState {
  @override
  List<Object?> get props => [];
}

class SaveLoadingState extends InventoryMovesState {
  final InventoryMoveModel inventoryMoveElements;
  const SaveLoadingState({required this.inventoryMoveElements});
  @override
  List<Object?> get props => [inventoryMoveElements];
}

class SaveLoadedState extends InventoryMovesState {
  final List<UserModel> users;
  const SaveLoadedState({required this.users});
  @override
  List<Object?> get props => [users];
}

class SaveErrorState extends InventoryMovesState {
  final InventoryMoveModel inventoryMoveElements;
  final String errorMessage;
  const SaveErrorState(
      {required this.inventoryMoveElements, required this.errorMessage});
  @override
  List<Object?> get props => [inventoryMoveElements, errorMessage];
}

class ErrorState extends InventoryMovesState {
  final String error;
  const ErrorState({required this.error});
  @override
  String toString() => 'Error en InventoryMoveState: $error';
  @override
  List<Object?> get props => [error];
}
