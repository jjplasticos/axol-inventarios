class ProductModel {
  final String code;
  final String description;
  final Map<String, dynamic> properties;

  ProductModel({
    required this.code,
    required this.description,
    required this.properties,
  });

  static ProductModel emptyValue() {
    return ProductModel(
      code: '',
      description: '',
      properties: {
        'code': '',
        'description': '',
        'type': '',
        'pices': '',
        'weight': '',
        'measure': '',
        'packing': '',
        'capacity': '',
        'gauge': '',
      }
    );
  }
}
