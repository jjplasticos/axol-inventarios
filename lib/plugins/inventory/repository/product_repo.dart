import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepo {
  final String TABLE = 'products';
  final String CODE = 'code';
  final String PRODUCT = 'attributes';
  final supabase = Supabase.instance.client;

  Future<List<Map>> readProductList(List<String> codeList) async {
    Map<String, dynamic> element;
    List<Map> newList = [];
    List productList = [];

    productList = await supabase.from(TABLE).select().in_(CODE, codeList);

    if (productList.isNotEmpty) {
      for (element in productList) {
        newList.add(element[PRODUCT]);
      }
    }

    return newList;
  }
}
