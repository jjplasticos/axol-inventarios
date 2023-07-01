import 'package:equatable/equatable.dart';

import '../../model/product_model.dart';
import '../../../../models/textfield_model.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class InitialState extends ProductsState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends ProductsState {
  final TextfieldModel finder;
  final int mode;
  const LoadingState({required this.finder, required this.mode});
  @override
  List<Object?> get props => [finder];
}

class LoadedState extends ProductsState {
  final List<ProductModel> products;
  final TextfieldModel finder;
  final int mode;
  const LoadedState(
      {required this.products, required this.finder, required this.mode});
  @override
  List<Object?> get props => [products, finder, mode];
}

class EditState extends ProductsState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends ProductsState {
  final String error;
  const ErrorState({required this.error});
  @override
  String toString() => 'Error: $error';
  @override
  List<Object?> get props => [error];
}
