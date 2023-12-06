import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/inventory_move/inventory_move_concept_model.dart';

class InventoryConceptsRepo {
  static const String _table = 'inventory_concepts';
  static const String _id = 'id';
  static const String _type = 'type';
  static const String _concept = 'concept';
  static final _supabase = Supabase.instance.client;

  Future<List<InventoryMoveConceptModel>> fetchAllConcepts() async {
    List<Map<String, dynamic>> conceptsDB = [];
    List<InventoryMoveConceptModel> concepts = [];
    InventoryMoveConceptModel concept;

    conceptsDB =
        await _supabase.from(_table).select<List<Map<String, dynamic>>>();
    for (var element in conceptsDB) {
      concept = InventoryMoveConceptModel(
        concept: element[_concept].toString(),
        id: int.parse(element[_id].toString()),
        type: int.parse(element[_type].toString()),
      );
      concepts.add(concept);
    }

    return concepts;
  }
}
