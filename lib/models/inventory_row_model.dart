import 'product_model.dart';

class InventoryRowModel {
  final ProductModel product;
  final double stock;

  const InventoryRowModel({required this.product, required this.stock});
}
