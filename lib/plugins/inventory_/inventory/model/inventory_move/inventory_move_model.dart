import 'inventory_move_concept_model.dart';
import 'inventory_move_row_model.dart';

class InventoryMoveModel {
  List<InventoryMoveRowModel> products;
  List<InventoryMoveConceptModel> concepts;
  String concept;
  String document;
  DateTime date;
  String invTransfer;
  Map<String, String> states;

  InventoryMoveModel({
    required this.products,
    required this.concept,
    required this.date,
    required this.document,
    required this.concepts,
    required this.invTransfer,
    required this.states,
  });

  static const String tProducts = 'products';
  static const String tConcept = 'concept';
  static const String tDate = 'date';
  static const String tDocument = 'document';
  static const String tConcepts = 'concepts';
  static const String tInvTransfer = 'invTransfer';
  static const String tStates = 'states';

  static const String sInitial = 'stateInitial';
  static const String sLoaded = 'stateLoaded';
  static const String sLoading = 'stateLoading';
  static const String sError = 'stateError';

  static InventoryMoveModel empty() => InventoryMoveModel(
        products: [],
        concept: '',
        date: DateTime.now(),
        document: '',
        concepts: [],
        invTransfer: '',
        states: {
          tProducts: sInitial,
          tConcept: sInitial,
          tDate: sInitial,
          tDocument: sInitial,
          tConcepts: sInitial,
          tInvTransfer: sInitial,
          tStates: sInitial,
        }
      );
}
