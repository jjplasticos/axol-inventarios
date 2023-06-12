import 'package:equatable/equatable.dart';

import '../../model/movement_model.dart';

abstract class MovementsState extends Equatable {
  const MovementsState();
}

class InitialState extends MovementsState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends MovementsState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends MovementsState {
  final List<MovementModel> movements;
  const LoadedState({required this.movements});
  @override
  List<Object?> get props => [movements];
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
