import 'inventory_move_row_model.dart';

class InventoryMoveElementsModel {
  final List<InventoryMoveRowModel> products;
  final List<String> concepts;
  final String concept;
  final String document;
  final String date;

  const InventoryMoveElementsModel({
    required this.products,
    required this.concept,
    required this.date,
    required this.document,
    required this.concepts,
  });
}
