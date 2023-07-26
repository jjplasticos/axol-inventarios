import 'package:equatable/equatable.dart';

abstract class RoutcustomerState extends Equatable {
  const RoutcustomerState();
}

class InitialState extends RoutcustomerState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends RoutcustomerState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends RoutcustomerState {
  @override
  List<Object?> get props => [];
}

class EditState extends RoutcustomerState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends RoutcustomerState {
  final String error;
  const ErrorState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}