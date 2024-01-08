import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/sale_note_model.dart';
import '../../model/salenote_filter_model.dart';
import '../../repository/sale_note_repo.dart';
import 'salenote_add_state.dart';

class SaleNoteAddCubit extends Cubit<SaleNoteAddState> {
  SaleNoteAddCubit() : super(InitialSaleNoteAddState());

  Future<void> load(String find) async {
    List<SaleNoteModel> salenoteListDB;
    try {
      emit(InitialSaleNoteAddState());
      emit(LoadingSaleNoteAddState());
      salenoteListDB =
          await SaleNoteRepo().fetchNotes(SaleNoteFilterModel.empty(), find);
      emit(LoadedSaleNoteAddState(salenoteList: salenoteListDB));
    } catch (e) {
      emit(InitialSaleNoteAddState());
      emit(ErrorSaleNoteAddState(error: e.toString()));
    }
  }
}