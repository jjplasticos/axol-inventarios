import 'package:equatable/equatable.dart';

import '../../model/sale_note_mdoel.dart';

abstract class SalenoteState extends Equatable {
  const SalenoteState();
}

class InitialState extends SalenoteState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends SalenoteState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends SalenoteState {
  final List<SaleNoteModel> salenoteList;
  const LoadedState({required this.salenoteList});
  @override
  List<Object?> get props => [salenoteList];
}

class ErrorState extends SalenoteState {
  final String error;
  const ErrorState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
