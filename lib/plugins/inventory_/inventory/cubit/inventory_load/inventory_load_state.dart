import 'package:equatable/equatable.dart';

import '../../../../models/inventory_row_model.dart';

abstract class InventoryLoadState extends Equatable {
  const InventoryLoadState();
}

class InitialState extends InventoryLoadState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends InventoryLoadState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends InventoryLoadState {
  final List<InventoryRowModel> inventoryList;

  const LoadedState({required this.inventoryList});

  @override
  List<Object?> get props => [inventoryList];
}

class ErrorState extends InventoryLoadState {
  final String error;

  const ErrorState({required this.error});

  @override
  String toString() => 'Error: $error';

  @override
  List<Object?> get props => [error];
}
