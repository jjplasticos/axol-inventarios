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

  static WarehouseModel fillMap(Map<String, dynamic> map) {
    WarehouseModel warehouseModel;
    if (map.containsKey(propId) &&
        map.containsKey(propName) &&
        map.containsKey(propManager)) {
      warehouseModel = WarehouseModel(
          id: map[propId],
          name: map[propName],
          retailManager: map[propManager]);
    } else {
      warehouseModel = WarehouseModel.empty();
    }
    return warehouseModel;
  }
}
