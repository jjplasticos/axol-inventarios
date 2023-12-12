import '../../../../../utilities/data_state.dart';
import 'inventory_move_concept_model.dart';
import 'inventory_move_row_model.dart';

class InventoryMoveModel {
  List<InventoryMoveRowModel> moveList;
  List<InventoryMoveConceptModel> concepts;
  String concept;
  String document;
  DateTime date;
  String invTransfer;
  Map<String, DataState> states;

  InventoryMoveModel({
    required this.moveList,
    required this.concept,
    required this.date,
    required this.document,
    required this.concepts,
    required this.invTransfer,
    required this.states,
  });

  static const String _moveList = 'moveList';
  static const String _concept = 'concept';
  static const String _date = 'date';
  static const String _document = 'document';
  static const String _concepts = 'concepts';
  static const String _invTransfer = 'invTransfer';

  String get tMoveList => _moveList;
  String get tConcept => _concept;
  String get tDate => _date;
  String get tDocument => _document;
  String get tConcepts => _concepts;
  String get tInvTransfer => _invTransfer;

  InventoryMoveModel.empty() :
        moveList = [],
        concept = '',
        date = DateTime.now(),
        document = '',
        concepts = [],
        invTransfer = '',
        states = {
          _moveList: DataState(state: DataState.initial),
          _concept: DataState(state: DataState.initial),
          _date: DataState(state: DataState.initial),
          _document: DataState(state: DataState.initial),
          _concepts: DataState(state: DataState.initial),
          _invTransfer: DataState(state: DataState.initial),
        }
      ;
}
