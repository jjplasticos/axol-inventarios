import 'package:equatable/equatable.dart';

import '../../model/sale_note_model.dart';

abstract class SaleNoteTabState extends Equatable {
  const SaleNoteTabState();
}

class InitialSaleNoteState extends SaleNoteTabState {
  @override
  List<Object?> get props => [];
}

class LoadingSaleNoteState extends SaleNoteTabState {
  @override
  List<Object?> get props => [];
}

class LoadedSaleNoteState extends SaleNoteTabState {
  final List<SaleNoteModel> salenoteList;
  const LoadedSaleNoteState({required this.salenoteList});
  @override
  List<Object?> get props => [salenoteList];
}

class ErrorSalenoteState extends SaleNoteTabState {
  final String error;
  const ErrorSalenoteState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
