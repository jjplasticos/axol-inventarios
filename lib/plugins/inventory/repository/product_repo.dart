import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepo {
  final String TABLE = 'products';
  final String CODE = 'code';
  final String PRODUCT = 'attributes';
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchProductList(
      List<String> codeList) async {
    Map<String, dynamic> element;
    List<Map<String, dynamic>> newList = [];
    List productList = [];

    productList = await supabase.from(TABLE).select().in_(CODE, codeList);

    if (productList.isNotEmpty) {
      for (element in productList) {
        newList.add(element[PRODUCT]);
        //element[PRODUCTO] --> {code: Map<String, dynamic>}
      }
    }

    return newList;
  }
}
