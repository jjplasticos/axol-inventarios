import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/movement_filter_model.dart';
import '../model/movement_model.dart';

class MovementRepo {
  //Table
  static const String _table = 'movement_history';
  //Columns movement_history
  static const String _id = 'id';
  static const String _time = 'time';
  static const String _code = 'code';
  static const String _description = 'description';
  static const String _document = 'document';
  static const String _warehouse = 'warehouse';
  static const String _concept = 'concept';
  static const String _conceptType = 'concept_type';
  static const String _quantity = 'quantity';
  static const String _user = 'user';
  //Database
  static final _supabase = Supabase.instance.client;

  Future<void> insertMovemets(List<MovementModel> newMovements) async {
    //print(newMovements.first.code);
    for (var element in newMovements) {
      await _supabase.from(_table).insert({
        _id: element.id,
        _time: element.time,
        _code: element.code,
        _description: element.description,
        _document: element.document,
        _warehouse: element.warehouse,
        _concept: element.concept,
        _conceptType: element.conceptType,
        _quantity: element.quantity,
        _user: element.user,
      });
    }
  }

  Future<List<MovementModel>> fetchMovements(MovementFilterModel moveFilter , int limit, String? filter) async {
    List<MovementModel> movements = [];
    MovementModel move;
    int filterLimit;
    Map<String, dynamic> filters = {};
    List<Map<String, dynamic>> movementsDB = [];
    if (moveFilter.warehouse != null) {
      if (moveFilter.warehouse!.id != 'all') {
        filters[_warehouse] = moveFilter.warehouse;
      }
    }
    if (moveFilter.date != null) {
      if (moveFilter.date != 'HASTA HOY') {
        filters[_time] = moveFilter;
        //Cambiar a fechas serializadas
        //DateTime dateTime = DateTime.now();
        //dateTime.millisecondsSinceEpoch;
      }
    }
    if (filter == null || filter == '') {
      movementsDB = await _supabase
          .from(_table)
          .select<List<Map<String, dynamic>>>()
          .order(_time, ascending: false)
          .limit(limit);
    } else {
      movementsDB = await _supabase
          .from(_table)
          .select<List<Map<String, dynamic>>>()
          .or('$_code.ilike.%$filter%,$_description.ilike.%$filter%')
          .order(_time, ascending: false)
          .limit(limit);
    }

    if (movementsDB.isNotEmpty) {
      for (var element in movementsDB) {
        move = MovementModel(
          id: element[_id].toString(),
          code: element[_code].toString(),
          concept: element[_concept],
          conceptType: element[_conceptType],
          description: element[_description].toString(),
          document: element[_document].toString(),
          quantity: element[_quantity],
          time: element[_time].toString(),
          warehouse: element[_warehouse].toString(),
          user: element[_user].toString(),
        );
        movements.add(move);
      }
    }

    return movements;
  }
}
