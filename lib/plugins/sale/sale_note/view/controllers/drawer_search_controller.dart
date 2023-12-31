import 'package:axol_inventarios/plugins/sale/sale_note/cubit/drawer_search_cubit/drawer_search_cubit.dart';
import 'package:axol_inventarios/plugins/sale/sale_note/cubit/drawer_search_cubit/drawer_search_state.dart';
import 'package:axol_inventarios/plugins/sale/sale_note/view/widgets/drawer_search/drawer_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utilities/theme.dart';

class DrawerSearchController extends StatelessWidget {
  const DrawerSearchController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerSearchCubit, DrawerSearchState>(
      bloc: context.read<DrawerSearchCubit>()..loadCustomers(''),
      builder: (context, state) {
        if (state is LoadingState) {
          return const DrawerSearch(
            isLoading: true,
            listData: [],
          );
        } else if (state is LoadedState) {
          return DrawerSearch(
            isLoading: false,
            listData: state.listData,
          );
        } else if (state is ErrorState) {
          return Text(
            state.error,
            style: Typo.labelText1,
          );
        }
        return Text(
          'No emitio nada...',
          style: Typo.labelText1,
        );
      },
    );
  }
}
