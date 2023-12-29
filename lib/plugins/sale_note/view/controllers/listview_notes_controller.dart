import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/theme.dart';
import '../../cubit/sale_note_cubit/salenote_cubit.dart';
import '../../cubit/sale_note_cubit/salenote_state.dart';
import '../widgets/finder_salenote.dart';
import '../widgets/listview_salenote.dart';
import '../widgets/toolbar_salenote.dart';

class ListviewNotesController extends StatelessWidget {
  const ListviewNotesController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalenoteCubit, SalenoteState>(
      bloc: context.read<SalenoteCubit>()..loadList(),
      builder: (context, state) {
        if (state is LoadingState) {
          return const Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  FinderSalenote(
                    isLoading: true,
                  ),
                  LinearProgressIndicator(),
                  Expanded(child: SizedBox())
                ],
              )),
              ToolbarSaleNote(
                isLoading: true,
              ),
            ],
          );
        } else if (state is LoadedState) {
          return ListviewSaleNote(
            listData: state.salenoteList,
          );
        } else if (state is ErrorState) {
          return Text(
            state.error,
            style: Typo.labelText1,
          );
        }
        return Container();
      },
    );
  }
}
