import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/product_model.dart';
import '../../repository/product_repo.dart';
import 'drawer_product_state.dart';

class DrawerProductCubit extends Cubit<DrawerProductState> {
  DrawerProductCubit() : super(InitialState());

  List<Map<int, dynamic>> initialValidation(int numFields) {
    final List<Map<int, dynamic>> list = [];
    for (int i = 0; i < numFields; i++) {
      list.add({0: true, 1: ''});
    }
    return list;
  }

  Future<void> initialDrawer(
      ProductModel initialProduct, int numFields, int focus) async {
    try {
      emit(InitialState());
      emit(const LoadingState());
      final initValidatino = initialValidation(numFields);
      emit(LoadedState(
          product: initialProduct,
          validation: initValidatino,
          mode: 0,
          finalValidation: false,
          currentFocus: focus));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> codeValidation(String code, ProductModel currentProduct,
      List<Map<int, dynamic>> currentValidation, int focus) async {
    try {
      List<Map<int, dynamic>> validation = currentValidation;
      final ProductModel? productDB;
      ProductModel product;
      emit(InitialState());
      product = ProductModel(
          code: code,
          description: currentProduct.description,
          properties: currentProduct.properties);
      product.properties['code'] = code;
      emit(LoadingCodeState(
          product: product,
          validationCode: currentValidation,
          mode: 1,
          currentFocus: ++focus));
      if (code == '') {
        validation[0] = {0: false, 1: 'Ingrese una clave'};
      } else {
        productDB = await ProductRepo().fetchProductByCode(code);
        if (productDB == null) {
          validation[0] = {0: true, 1: ''};
        } else {
          validation[0] = {0: false, 1: 'Clave existente'};
        }
      }

      emit(LoadedState(
          product: product,
          validation: validation,
          mode: 0,
          finalValidation: false,
          currentFocus: ++focus));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<bool> formValidation(ProductModel currentProduct,
      List<Map<int, dynamic>> currentValidation) async {
    try {
      final bool finalValidation;
      int errors = 0;
      List<Map<int, dynamic>> validation = currentValidation;
      List<dynamic> properties = List.from(currentProduct.properties.values);
      for (int i = 0; i < properties.length; i++) {
        if (properties[i] == '') {
          validation[i] = {0: false, 1: 'Dato no admitido'};
        } else {
          validation[i] = currentValidation[i];
        }
      }
      for (var element in validation) {
        if (element[0] == false) {
          errors++;
        }
      }
      if (errors == 0) {
        finalValidation = true;
      } else {
        finalValidation = false;
      }
      emit(InitialState());
      emit(const LoadingState());
      emit(LoadedState(
          product: currentProduct,
          validation: currentValidation,
          mode: 0,
          finalValidation: finalValidation,
          currentFocus: 0));
      return finalValidation;
    } catch (e) {
      emit(ErrorState(error: e.toString()));
      return false;
    }
  }

  Future<void> singleValidation(
      String value,
      String nameField,
      ProductModel currentProduct,
      List<Map<int, dynamic>> currentValidation,
      bool isError,
      int field) async {
    try {
      List<Map<int, dynamic>> validation = currentValidation;
      ProductModel product;
      emit(InitialState());
      emit(const LoadingState());
      if (isError) {
        validation[field] = {0: false, 1: 'Dato no admitido'};
      } else {
        validation[field] = {0: true, 1: ''};
      }
      if (nameField == 'description') {
        product = ProductModel(
            code: currentProduct.code,
            description: value,
            properties: currentProduct.properties);
      } else {
        product = currentProduct;
      }
      product.properties[nameField] = value;
      emit(LoadedState(
          product: product,
          validation: validation,
          mode: 0,
          finalValidation: false,
          currentFocus: ++field));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
