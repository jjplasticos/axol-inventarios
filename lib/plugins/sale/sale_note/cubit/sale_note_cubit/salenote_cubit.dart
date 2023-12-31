import 'package:axol_inventarios/plugins/sale_note/model/salenote_filter_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/textfield_model.dart';
import '../../model/sale_note_model.dart';
import '../../repository/sale_note_repo.dart';
import 'salenote_state.dart';

class SalenoteCubit extends Cubit<SalenoteState> {
  SalenoteCubit() : super(InitialState());

  Future<void> loadList() async {
    try {
      emit(InitialState());
      emit(LoadingState());
      List<SaleNoteModel> notesDB;
      notesDB =
          await SaleNoteRepo().fetchNotes(SaleNoteFilterModel.empty(), '');
      emit(LoadedState(salenoteList: notesDB));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> reloadList(String finder, SaleNoteFilterModel filter) async {
    try {
      List<SaleNoteModel> notesDB;
      emit(InitialState());
      emit(LoadingState());
      notesDB = await SaleNoteRepo().fetchNotes(filter, finder);
      emit(LoadedState(salenoteList: notesDB));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
