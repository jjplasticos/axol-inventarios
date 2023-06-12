import 'package:equatable/equatable.dart';

import '../../model/movement_filter_model.dart';

abstract class MovementFiltersState extends Equatable {
  const MovementFiltersState();
}

class InitialState extends MovementFiltersState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends MovementFiltersState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends MovementFiltersState {
  final MovementFilterModel movementFilters;
  const LoadedState({required this.movementFilters});
  @override
  List<Object?> get props => [movementFilters];
}

class ErrorState extends MovementFiltersState {
  final String error;
  const ErrorState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
