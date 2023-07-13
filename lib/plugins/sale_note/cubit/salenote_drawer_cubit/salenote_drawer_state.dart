import 'package:equatable/equatable.dart';

abstract class SalenoteDrawerState extends Equatable {
  const SalenoteDrawerState();
}

class InitialState extends SalenoteDrawerState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends SalenoteDrawerState {
  const LoadingState();
  @override
  List<Object?> get props => [];
}

class LoadedState extends SalenoteDrawerState {
  const LoadedState();
  @override
  List<Object?> get props => [];
}

class ErrorState extends SalenoteDrawerState {
  final String error;
  const ErrorState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
