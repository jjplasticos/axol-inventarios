import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/movements_view/movements_cubit.dart';
import '../../cubit/movements_view/movements_state.dart';
import '../widgets/listview_movements.dart';

class ListviewMovementsController extends StatelessWidget {
  const ListviewMovementsController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovementsCuibit, MovementsState>(
      bloc: context.read<MovementsCuibit>()..loadList(),
      builder: (context, state) {
        if (state is LoadingState) {
          return const LinearProgressIndicator();
        } else if (state is LoadedState) {
          return ListviewMovements(
            movementsList: state.movements,
          );
        }
        return Container();
      },
    );
  }
}
