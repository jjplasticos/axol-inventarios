class WarehouseModel {
  final int id;
  final String name;
  final String retailManager;

  static const String propId = 'id';
  static const String propName = 'name';
  static const String propManager = 'retail_manager';

  const WarehouseModel({
    required this.id,
    required this.name,
    required this.retailManager,
  });

  static WarehouseModel empty() =>
      const WarehouseModel(id: -1, name: '', retailManager: '');
}
