import 'package:axol_inventarios/models/textfield_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routcustomer_state.dart';

class RoutcustomerCubit extends Cubit<RoutcustomerState> {
  RoutcustomerCubit() : super(InitialState());

  Future<void> load(TextfieldModel finder) async {
    try {
      emit(LoadingState());
      if (finder.text == '') {

      } else {

      }
      emit(LoadedState());
      TextfieldModel initialFinder = TextfieldModel(text: '', position: 0);
      List<ProductModel> products;
      emit(InitialState());
      emit(LoadingState(finder: initialFinder, mode: 0));
      products = await ProductRepo().fetchAllProducts();
      emit(LoadedState(products: products, finder: initialFinder, mode: 0));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> reloadList(TextfieldModel finder, int mode) async {
    try {
      List<ProductModel> products;
      emit(InitialState());
      emit(LoadingState(finder: finder, mode: mode));
      products = await ProductRepo().fetchProductFinder(finder.text);
      emit(LoadedState(products: products, finder: finder, mode: mode));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    await ProductRepo().updateProduct(product);
  }
}
