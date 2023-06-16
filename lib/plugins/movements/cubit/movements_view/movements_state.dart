import 'package:equatable/equatable.dart';

import '../../../../models/textfield_model.dart';
import '../../model/movement_filter_model.dart';
import '../../model/movement_model.dart';

abstract class MovementsState extends Equatable {
  const MovementsState();
}

class InitialState extends MovementsState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends MovementsState {
  final MovementFilterModel filters;
  final TextfieldModel finder;
  const LoadingState({required this.finder, required this.filters});
  @override
  List<Object?> get props => [finder, filters];
}

class LoadedState extends MovementsState {
  final MovementFilterModel filters;
  final List<MovementModel> movements;
  final TextfieldModel finder;
  const LoadedState(
      {required this.movements, required this.finder, required this.filters});
  @override
  List<Object?> get props => [movements, finder, filters];
}

class EditState extends MovementsState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends MovementsState {
  final String error;
  const ErrorState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
