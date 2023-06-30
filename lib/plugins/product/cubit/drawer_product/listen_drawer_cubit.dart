import 'package:axol_inventarios/plugins/product/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListenProductCubit extends Cubit<ProductModel> {
  ListenProductCubit() : super(ProductModel.emptyValue());

  Future<void> change(ProductModel product, int keyChange, String value) async {
    ProductModel changedProduct;
    Map<String, dynamic> properties = {};
    final List<dynamic> propertiesKeys = List.from(product.properties.keys);
    for (int i = 0; i <= propertiesKeys.length; i++) {
      if (i == keyChange) {
        properties[propertiesKeys[i]] = value;
      } else {
        properties[propertiesKeys[i]] = product.properties[i];
      }
    }
    changedProduct = ProductModel(
        code: product.code,
        description: product.description,
        properties: properties);
    emit(ProductModel.emptyValue());
    emit(changedProduct);
  }
}
