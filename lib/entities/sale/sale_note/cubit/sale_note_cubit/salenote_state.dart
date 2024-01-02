import 'package:equatable/equatable.dart';

import '../../model/sale_note_model.dart';

abstract class SalenoteState extends Equatable {
  const SalenoteState();
}

class InitialSaleNoteState extends SalenoteState {
  @override
  List<Object?> get props => [];
}

class LoadingSaleNoteState extends SalenoteState {
  @override
  List<Object?> get props => [];
}

class LoadedSaleNoteState extends SalenoteState {
  final List<SaleNoteModel> salenoteList;
  const LoadedSaleNoteState({required this.salenoteList});
  @override
  List<Object?> get props => [salenoteList];
}

class ErrorSalenoteState extends SalenoteState {
  final String error;
  const ErrorSalenoteState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
