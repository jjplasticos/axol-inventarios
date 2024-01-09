import 'package:equatable/equatable.dart';

abstract class SaleNoteAddState extends Equatable {
  const SaleNoteAddState();
}

class InitialSaleNoteAddState extends SaleNoteAddState {
  @override
  List<Object?> get props => [];
}

class LoadingSaleNoteAddState extends SaleNoteAddState {
  @override
  List<Object?> get props => [];
}

class LoadedSaleNoteAddState extends SaleNoteAddState {
  @override
  List<Object?> get props => [];
}

class ErrorSaleNoteAddState extends SaleNoteAddState {
  final String error;
  const ErrorSaleNoteAddState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
