import 'package:axol_inventarios/modules/sale/sale_note/model/sale_note_model.dart';
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
  final List<SaleNoteModel> salenoteList;
  const LoadedSaleNoteAddState({required this.salenoteList});
  @override
  List<Object?> get props => [salenoteList];
}

class ErrorSaleNoteAddState extends SaleNoteAddState {
  final String error;
  const ErrorSaleNoteAddState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
