import 'package:flutter_bloc/flutter_bloc.dart';

import 'movements_state.dart';

class MovementsCuibit extends Cubit<MovementsState> {
  MovementsCuibit() : super(InitialState());

  void loadList(String text) {
    try {
      emit(InitialState());
      emit(LoadingState());
      //Obtener lista de movimientos de base de datos
      emit(LoadedState());
      emit(EditState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
