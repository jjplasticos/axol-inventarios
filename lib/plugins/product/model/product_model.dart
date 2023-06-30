class ProductModel {
  final String code;
  final String description;
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
  });

  static ProductModel emptyValue() {
    return ProductModel(code: '', description: '', properties: {
      propCode: '',
      propDescription: '',
      propType: '',
      propGauge: '',
      propPieces: '',
      propWeight: '',
      propMeasure: '',
      propPacking: '',
      propCapacity: '',
    });
  }
}
