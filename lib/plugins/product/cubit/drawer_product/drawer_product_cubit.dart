import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/product_model.dart';
import '../../repository/product_repo.dart';
import 'drawer_product_state.dart';

class DrawerProductCubit extends Cubit<DrawerProductState> {
  DrawerProductCubit() : super(InitialState());

  Future<void> initialDrawer(ProductModel initialProduct) async {
    try {
      emit(InitialState());
      emit(const LoadingState());
      emit(LoadedState(
          product: initialProduct, validationCode: const {0: true, 1: ''}));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> codeValidation(String code, ProductModel currentProduct) async {
    try {
      final Map<int, dynamic> validation;
      final ProductModel? product;
      emit(InitialState());
      emit(const LoadingCodeState());
      if (code == '') {
        validation = {0: false, 1: 'Ingrese una clave'};
      } else {
        product = await ProductRepo().fetchProductByCode(code);
        if (product == null) {
          validation = {0: true, 1: ''};
        } else {
          validation = {0: false, 1: 'Clave existente'};
        }
      }
      emit(LoadedState(product: currentProduct, validationCode: validation));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
