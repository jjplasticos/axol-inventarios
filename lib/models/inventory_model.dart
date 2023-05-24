class InventoryModel {
  final String id;
  final double stock;
  final String retailManager;
  final String name;
  final String code;

  const InventoryModel({
    required this.code,
    required this.id,
    required this.name,
    required this.retailManager,
    required this.stock,
  });
}
