import 'package:equatable/equatable.dart';

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
  final List<String> names;

  const LoadedState({required this.names});

  @override
  List<Object?> get props => [names];
}

class ErrorState extends WarehousesLoadState {
  final String error;

  const ErrorState({required this.error});

  @override
  String toString() => 'Error: $error';

  @override
  List<Object?> get props => [error];
}
