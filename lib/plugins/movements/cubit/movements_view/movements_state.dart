import 'package:equatable/equatable.dart';

import '../../../../models/textfield_model.dart';
import '../../model/movement_model.dart';

abstract class MovementsState extends Equatable {
  const MovementsState();
}

class InitialState extends MovementsState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends MovementsState {
  final TextfieldModel finder;
  const LoadingState({required this.finder});
  @override
  List<Object?> get props => [finder];
}

class LoadedState extends MovementsState {
  final List<MovementModel> movements;
  final TextfieldModel finder;
  const LoadedState({required this.movements, required this.finder});
  @override
  List<Object?> get props => [movements, finder];
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
