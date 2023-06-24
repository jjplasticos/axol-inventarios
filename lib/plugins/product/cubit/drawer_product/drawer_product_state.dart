import 'package:equatable/equatable.dart';

import '../../../../models/product_model.dart';

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
  const LoadingCodeState();
  @override
  List<Object?> get props => [];
}

class LoadedState extends DrawerProductState {
  final ProductModel product;
  final Map<int, dynamic> validationCode;
  const LoadedState({required this.product, required this.validationCode});
  @override
  List<Object?> get props => [product, validationCode];
}

class EditState extends DrawerProductState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends DrawerProductState {
  final String error;
  const ErrorState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
