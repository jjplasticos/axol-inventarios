import 'package:equatable/equatable.dart';

import '../../model/product_model.dart';

abstract class DrawerProductState extends Equatable {
  const DrawerProductState();
}

class InitialState extends DrawerProductState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends DrawerProductState {
  const LoadingState();
  @override
  List<Object?> get props => [];
}

class LoadingCodeState extends DrawerProductState {
  final ProductModel product;
  final List<Map<int, dynamic>> validationCode;
  final int mode;
  final int currentFocus;
  const LoadingCodeState(
      {required this.product,
      required this.validationCode,
      required this.mode,
      required this.currentFocus});
  @override
  List<Object?> get props => [product, validationCode, mode, currentFocus];
}

class LoadedState extends DrawerProductState {
  final ProductModel product;
  final List<Map<int, dynamic>> validation;
  final int mode;
  final bool finalValidation;
  final int currentFocus;
  const LoadedState(
      {required this.product,
      required this.validation,
      required this.mode,
      required this.finalValidation,
      required this.currentFocus});
  @override
  List<Object?> get props =>
      [product, validation, mode, finalValidation, currentFocus];
}

class ErrorState extends DrawerProductState {
  final String error;
  const ErrorState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
