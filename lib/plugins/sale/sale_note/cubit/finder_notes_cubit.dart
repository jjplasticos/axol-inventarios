import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/textfield_model.dart';

class FinderNotesCubit extends Cubit<TextfieldModel> {
  FinderNotesCubit() : super(TextfieldModel.empty());

  Future<void> change(String value, int position) async {
    TextfieldModel newTextfield =
        TextfieldModel(text: value, position: position);
    emit(TextfieldModel.empty());
    emit(newTextfield);
  }

  Future<void> getState() async {
    emit(TextfieldModel.empty());
    emit(state);
  }

  void setState(TextfieldModel textfield) {
    emit(TextfieldModel.empty());
    emit(textfield);
  }
}
