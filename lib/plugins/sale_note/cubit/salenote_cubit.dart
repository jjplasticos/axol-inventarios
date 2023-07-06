import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/textfield_model.dart';
import '../model/sale_note_mdoel.dart';
import 'salenote_state.dart';

class SaleNoteCubit extends Cubit<SaleNoteState> {
  SaleNoteCubit() : super(InitialState());

  /*Future<void> initialList() async {
    try {
      TextfieldModel initialFinder =
          const TextfieldModel(text: '', position: 0);
      List<SaleNoteModel> salesNotes;
      emit(InitialState());
      emit(LoadingState(finder: initialFinder));
      salesNotes = await ProductRepo().fetchAllProducts();
      emit(LoadedState(salesNotes: salesNotes, finder: initialFinder));
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
  }*/
}
