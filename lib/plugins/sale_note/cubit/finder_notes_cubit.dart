import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/textfield_model.dart';

class FinderNotesCubit extends Cubit<TextfieldModel> {
  FinderNotesCubit() : super(TextfieldModel.initial());

  Future<void> change(String value, int position) async {
    TextfieldModel newTextfield = TextfieldModel(text: value, position: position);
    emit(TextfieldModel.initial());
    emit(newTextfield);
  }

  Future<void> getState()async{
    emit(TextfieldModel.initial());
    emit(state);
  }
}