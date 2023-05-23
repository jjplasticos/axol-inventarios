import 'package:equatable/equatable.dart';

import '../../../../models/inventory_move_elements_model.dart';

abstract class InventoryMovesState extends Equatable {
  const InventoryMovesState();
}

class EditInitialState extends InventoryMovesState {
  @override
  List<Object?> get props => [];
}

class EditState extends InventoryMovesState {
  final InventoryMoveElementsModel inventoryMoveElements;
  const EditState({required this.inventoryMoveElements});
  @override
  List<Object?> get props => [inventoryMoveElements];
}

class SaveInitialState extends InventoryMovesState {
  @override
  List<Object?> get props => [];
}

class SaveLoadingState extends InventoryMovesState {
  final InventoryMoveElementsModel inventoryMoveElements;
  const SaveLoadingState({required this.inventoryMoveElements});
  @override
  List<Object?> get props => [inventoryMoveElements];
}

class SaveLoadedState extends InventoryMovesState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends InventoryMovesState {
  final String error;
  const ErrorState({required this.error});
  @override
  String toString() => 'Error en InventoryMoveState: $error';
  @override
  List<Object?> get props => [error];
}
