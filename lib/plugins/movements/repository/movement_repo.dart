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
  static const String _stock = 'stock';
  //Database
  static final _supabase = Supabase.instance.client;

  Future<void> insertMovemets(List<MovementModel> newMovements) async {
    //print(newMovements.first.code);
    for (var element in newMovements) {
      await _supabase.from(_table).insert({
        _id: element.id,
        _time: element.time.millisecondsSinceEpoch,
        _code: element.code,
        _description: element.description,
        _document: element.document,
        _warehouse: element.warehouse,
        _concept: element.concept,
        _conceptType: element.conceptType,
        _quantity: element.quantity,
        _user: element.user,
        _stock: element.stock,
      });
    }
  }

  Future<List<MovementModel>> fetchMovements(MovementFilterModel moveFilter,
      String? filter, bool ascending, int mode) async {
    List<MovementModel> movements = [];
    MovementModel move;
    int filterLimit = 50;
    int filterStartDate = 0;
    int filterEndDate = 32503708800000;
    Map<String, dynamic> filters = {};
    List<Map<String, dynamic>> movementsDB = [];

    if (moveFilter.warehouse.id != 'all') {
      filters[_warehouse] = moveFilter.warehouse.name;
      //print(filters[_warehouse].warehouse as MovementFilterModel);
    }
    if (moveFilter.date[0]!.year != 0) {
      filterStartDate = moveFilter.date[0]!.millisecondsSinceEpoch;
      filterEndDate = moveFilter.date[1]!.millisecondsSinceEpoch;
    }
    if (moveFilter.concept.id != -1) {
      filters[_concept] = moveFilter.concept.id;
    }
    if (moveFilter.user.uid != 'all') {
      filters[_user] = moveFilter.user.name;
    }
    if (moveFilter.currentLimit.text != '50') {
      filterLimit = int.parse(moveFilter.currentLimit.text);
    }
    if (filter == null || filter == '') {
      movementsDB = await _supabase
          .from(_table)
          .select<List<Map<String, dynamic>>>()
          .match(filters)
          .lte(_time, filterEndDate)
          .gte(_time, filterStartDate)
          .order(_time, ascending: ascending)
          .limit(filterLimit);
    } else {
      if (mode == 1) {
        movementsDB = await _supabase
            .from(_table)
            .select<List<Map<String, dynamic>>>()
            .or('$_code.ilike.%$filter%,$_description.ilike.%$filter%,$_document.ilike.%$filter%')
            .match(filters)
            .lte(_time, filterEndDate)
            .gte(_time, filterStartDate)
            .order(_time, ascending: ascending)
            .limit(filterLimit);
      } else {
        movementsDB = await _supabase
            .from(_table)
            .select<List<Map<String, dynamic>>>()
            .or('$_code.ilike.%$filter%,$_description.ilike.%$filter%,$_document.ilike.%$filter%')
            .match(filters)
            .lte(_time, filterEndDate)
            .gte(_time, filterStartDate)
            .order(_time, ascending: ascending)
            .limit(filterLimit);
      }
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
            time:
                DateTime.fromMillisecondsSinceEpoch(int.parse(element[_time])),
            warehouse: element[_warehouse].toString(),
            user: element[_user].toString(),
            stock: element[_stock]);
        movements.add(move);
      }
    }

    return movements;
  }
}
