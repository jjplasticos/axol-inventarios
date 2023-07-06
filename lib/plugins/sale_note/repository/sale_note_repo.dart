import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/sale_note_mdoel.dart';
import '../model/salenote_filter_model.dart';

class SaleNoteRepo {
  static const String _table = 'sales_notes';
  final _supabase = Supabase.instance.client;

  Future<List<SaleNoteModel>> fetchNotes(
      SaleNoteFilterModel filter, String finder) async {
    List<SaleNoteModel> salesNotes = [];
    SaleNoteModel saleNote;
    List<Map<String, dynamic>> saleNoteDB = [];
    Map<String, dynamic> filters = {};

    /*if (filter.product != '') {
      filters
    }

    await _supabase.from(_table).select().filter(column, operator, value)*/

    return salesNotes;
  }
}
