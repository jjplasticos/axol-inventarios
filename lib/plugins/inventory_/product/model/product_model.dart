class ProductModel {
  final String code;
  final String description;
  final int class_;
  final Map<String, dynamic> properties;

  static const String propCode = 'code';
  static const String propDescription = 'description';
  static const String propType = 'type';
  static const String propGauge = 'gauge';
  static const String propPieces = 'pices';
  static const String propWeight = 'weight';
  static const String propMeasure = 'measure';
  static const String propPacking = 'packing';
  static const String propCapacity = 'capacity';

  ProductModel({
    required this.code,
    required this.description,
    required this.properties,
    required this.class_,
  });

  static ProductModel emptyValue() {
    return ProductModel(
        code: '',
        description: '',
        properties: {
          propCode: '',
          propDescription: '',
          propType: '',
          propGauge: '',
          propPieces: '',
          propWeight: '',
          propMeasure: '',
          propPacking: '',
          propCapacity: '',
        },
        class_: -1);
  }

  static ProductModel sortProduct(ProductModel product) {
    ProductModel newProduct;
    Map<String, dynamic> newMap = {};
    final List<String> propList =
        List.from(ProductModel.emptyValue().properties.keys);
    for (var element in propList) {
      if (product.properties.containsKey(element)) {
        newMap[element] = product.properties[element];
      }
    }
    newProduct = ProductModel(
      code: product.code,
      description: product.description,
      properties: newMap,
      class_: product.class_,
    );
    return newProduct;
  }
}
