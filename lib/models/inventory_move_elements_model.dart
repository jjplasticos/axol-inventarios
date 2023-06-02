import 'inventory_move_concept_model.dart';
import 'inventory_move_row_model.dart';

class InventoryMoveElementsModel {
  final List<InventoryMoveRowModel> products;
  final List<InventoryMoveConceptModel> concepts;
  final String concept;
  final String document;
  final String date;
  final String invTransfer;

  const InventoryMoveElementsModel({
    required this.products,
    required this.concept,
    required this.date,
    required this.document,
    required this.concepts,
    required this.invTransfer,
  });
}
