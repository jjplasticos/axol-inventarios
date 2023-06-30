import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/product_model.dart';

class ProductRepo {
  static const String _table = 'products';
  static const String _code = 'code';
  static const String _properties = 'attributes';
  static const String _description = 'description';
  final _supabase = Supabase.instance.client;

  Future<List<ProductModel>> fetchProductList(List<String> codeList) async {
    //Map<String, dynamic> properties;
    List<ProductModel> products = [];
    ProductModel product;
    //List<Map<String, dynamic>> newList = [];
    List<Map<String, dynamic>> productsDB = [];

    productsDB = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .in_(_code, codeList);

    if (productsDB.isNotEmpty) {
      for (var element in productsDB) {
        product = ProductModel(
          code: element[_code],
          description: element[_description],
          properties: element[_properties],
        );
        products.add(product);
      }
      //newList.add(properties[_product]);
      //element[PRODUCTO] --> {code: Map<String, dynamic>}
    }
    return products;
  }

  Future<Map<String, dynamic>> fetchProduct(String code) async {
    List<Map<String, dynamic>> products;
    Map<String, dynamic> product;

    products = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .eq(_code, code);
    if (products.isNotEmpty) {
      product = products.first;
    } else {
      product = {};
    }

    return product;
  }

  Future<ProductModel?> fetchProductByCode(String code) async {
    ProductModel? product;
    List<Map<String, dynamic>> productsDB;

    productsDB = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .eq(_code, code);

    if (productsDB.length == 1) {
      product = ProductModel(
          code: productsDB.single[_code],
          description: productsDB.single[_description],
          properties: productsDB.single[_properties]);
    } else {
      product = null;
    }

    return product;
  }

  Future<List<ProductModel>> fetchAllProducts() async {
    ProductModel product;
    List<ProductModel> products = [];
    List<Map<String, dynamic>> productsDB;
    productsDB =
        await _supabase.from(_table).select<List<Map<String, dynamic>>>();
    if (productsDB.isNotEmpty) {
      for (var element in productsDB) {
        product = ProductModel(
          code: element[_code],
          description: element[_description],
          properties: element[_properties],
        );
        products.add(product);
      }
    }
    return products;
  }

  Future<List<ProductModel>> fetchProductFinder(String finder) async {
    ProductModel product;
    List<ProductModel> products = [];
    List<Map<String, dynamic>> productsDB;
    productsDB = await _supabase
        .from(_table)
        .select<List<Map<String, dynamic>>>()
        .or('$_code.ilike.%$finder%,$_description.ilike.%$finder%');
    if (productsDB.isNotEmpty) {
      for (var element in productsDB) {
        product = ProductModel(
          code: element[_code],
          description: element[_description],
          properties: element[_properties],
        );
        products.add(product);
      }
    }
    return products;
  }

  Future<void> insertProduct(ProductModel product) async {
    await _supabase.from(_table).insert(
     {
       _code: product.code,
       _description: product.description,
       _properties: product.properties,
     } 
    );
  }
}
