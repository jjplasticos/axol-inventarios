import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/product_model.dart';
import '../../../../models/textfield_model.dart';
import '../../repository/product_repo.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(InitialState());

  Future<void> initialList() async {
    try {
      TextfieldModel initialFinder =
          const TextfieldModel(text: '', position: 0);
      List<ProductModel> products;
      emit(InitialState());
      emit(LoadingState(finder: initialFinder));
      products = await ProductRepo().fetchAllProducts();
      emit(LoadedState(products: products, finder: initialFinder));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> reloadList(TextfieldModel finder) async {
    try {
      List<ProductModel> products;
      emit(InitialState());
      emit(LoadingState(finder: finder));
      products = await ProductRepo().fetchProductFinder(finder.text);
      emit(LoadedState(products: products, finder: finder));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
