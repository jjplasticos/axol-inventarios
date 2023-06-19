import 'package:axol_inventarios/plugins/movements/repository/movement_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/textfield_model.dart';
import '../../model/movement_filter_model.dart';
import '../../model/movement_model.dart';
import 'movements_state.dart';

class MovementsCuibit extends Cubit<MovementsState> {
  MovementsCuibit() : super(InitialState());

  Future<void> loadList() async {
    try {
      MovementFilterModel filters = MovementFilterModel.initialValue();
      List<MovementModel> movements;
      emit(InitialState());
      emit(LoadingState(
          filters: filters,
          finder: const TextfieldModel(text: '', position: 0)));
      //Obtener lista de movimientos de base de datos
      movements = await MovementRepo().fetchMovements(filters, null);
      emit(LoadedState(
          movements: movements,
          finder: const TextfieldModel(text: '', position: 0),
          filters: filters));
      //emit(EditState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> finderList(
      MovementFilterModel filters, TextfieldModel finder) async {
    try {
      List<MovementModel> movements;
      emit(InitialState());
      emit(LoadingState(finder: finder, filters: filters));
      movements = await MovementRepo().fetchMovements(filters, finder.text);
      emit(LoadedState(movements: movements, finder: finder, filters: filters));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  /*Future<void> changeFilters() async {
    try {
      List<MovementModel> movements;
      emit(InitialState());
      emit(LoadingState(finder: finder, filters: filters));
      movements = await MovementRepo().fetchMovements(filters, finder.text);
      emit(LoadedState(movements: movements, finder: finder, filters: filters));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }*/
}
