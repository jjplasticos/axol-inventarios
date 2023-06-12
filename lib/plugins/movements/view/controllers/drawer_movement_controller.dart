import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/movement_filters/movement_filters_cubit.dart';
import '../../cubit/movement_filters/movement_filters_state.dart';
import '../../model/movement_filter_model.dart';
import '../widgets/drawer_movements.dart';

class DrawerMovementsController extends StatelessWidget {
  const DrawerMovementsController({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          color: Colors.black26,
        )),
        Drawer(
          width: 500,
          child: BlocBuilder<MovementFiltersCubit, MovementFiltersState>(
            bloc: context.read<MovementFiltersCubit>()
              ..getWarehouses(const MovementFilterModel()),
            builder: (context, state) {
              if (state is LoadingState) {
                return Column(
                  children: const [
                    LinearProgressIndicator(),
                    Expanded(child: SizedBox())
                  ],
                );
              } else if (state is LoadedState) {
                return DrawerMovements(
                  filters: state.movementFilters,
                );
              } else if (state is ErrorState) {
                return Text(state.error);
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
