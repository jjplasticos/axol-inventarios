import 'package:axol_inventarios/plugins/movements/repository/movement_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/movement_model.dart';
import 'movements_state.dart';

class MovementsCuibit extends Cubit<MovementsState> {
  MovementsCuibit() : super(InitialState());

  Future<void> loadList() async {
    try {
      List<MovementModel> movements;
      emit(InitialState());
      emit(LoadingState());
      //Obtener lista de movimientos de base de datos
      movements = await MovementRepo().fetchMovements(50);
      emit(LoadedState(movements: movements));
      //emit(EditState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
