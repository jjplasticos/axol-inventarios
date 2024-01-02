import 'package:axol_inventarios/modules/sale/sale_note/model/salenote_filter_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/textfield_model.dart';
import '../../model/sale_note_model.dart';
import '../../repository/sale_note_repo.dart';
import 'salenote_state.dart';

class SalenoteCubit extends Cubit<SalenoteState> {
  SalenoteCubit() : super(InitialSaleNoteState());

  Future<void> loadList() async {
    try {
      emit(InitialSaleNoteState());
      emit(LoadingSaleNoteState());
      List<SaleNoteModel> notesDB;
      notesDB =
          await SaleNoteRepo().fetchNotes(SaleNoteFilterModel.empty(), '');
      emit(LoadedSaleNoteState(salenoteList: notesDB));
    } catch (e) {
      emit(ErrorSalenoteState(error: e.toString()));
    }
  }

  Future<void> reloadList(String finder, SaleNoteFilterModel filter) async {
    try {
      List<SaleNoteModel> notesDB;
      emit(InitialSaleNoteState());
      emit(LoadingSaleNoteState());
      notesDB = await SaleNoteRepo().fetchNotes(filter, finder);
      emit(LoadedSaleNoteState(salenoteList: notesDB));
    } catch (e) {
      emit(ErrorSalenoteState(error: e.toString()));
    }
  }
}
