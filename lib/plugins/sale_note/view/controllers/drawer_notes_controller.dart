import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../settings/theme.dart';
import '../../cubit/salenote_drawer_cubit/salenote_drawer_cubit.dart';
import '../../cubit/salenote_drawer_cubit/salenote_drawer_state.dart';
import '../widgets/drawer_sale_note.dart';

class ListviewNotesController extends StatelessWidget {
  const ListviewNotesController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalenoteDrawerCubit, SalenoteDrawerState>(
      bloc: context.read<SalenoteDrawerCubit>()..initial(),
      builder: (context, state) {
        if (state is LoadingState) {
          return const DrawerSalenote(isLoading: true,);
        } else if (state is LoadedState) {
          return const DrawerSalenote(isLoading: false,);
        } else if (state is ErrorState) {
          return Text(
            state.error,
            style: Typo.labelText1,
          );
        }
        return Text('No emitio nada...', style: Typo.labelText1,);
      },
    );
  }
}