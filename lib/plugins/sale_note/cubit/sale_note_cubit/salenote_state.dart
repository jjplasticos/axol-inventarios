import 'package:equatable/equatable.dart';

import '../../../../models/textfield_model.dart';
import '../../model/sale_note_mdoel.dart';

abstract class SaleNoteState extends Equatable {
  const SaleNoteState();
}

class InitialState extends SaleNoteState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends SaleNoteState {
  final TextfieldModel finder;
  const LoadingState({required this.finder});
  @override
  List<Object?> get props => [finder];
}

class LoadedState extends SaleNoteState {
  final List<SaleNoteModel> salesNotes;
  final TextfieldModel finder;
  const LoadedState({required this.finder, required this.salesNotes});
  @override
  List<Object?> get props => [salesNotes, finder];
}

class ErrorState extends SaleNoteState {
  final String error;
  const ErrorState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
