import 'inventory_move_concept_model.dart';
import 'inventory_move_row_model.dart';

class InventoryMoveModel {
  List<InventoryMoveRowModel> products;
  List<InventoryMoveConceptModel> concepts;
  String concept;
  String document;
  DateTime date;
  String invTransfer;

  InventoryMoveModel({
    required this.products,
    required this.concept,
    required this.date,
    required this.document,
    required this.concepts,
    required this.invTransfer,
  });

  static InventoryMoveModel empty() => InventoryMoveModel(
        products: [],
        concept: '',
        date: DateTime.now(),
        document: '',
        concepts: [],
        invTransfer: '',
      );
}
