class InventoryRowModel {
  final String code;
  final Map<String, dynamic> properties;
  final double stock;

  const InventoryRowModel(
      {required this.code, required this.properties, required this.stock});
}
