import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/inventory_load/inventory_load_cubit.dart';
import '../../cubit/inventory_load/inventory_load_state.dart';
import '../widgets/inventory_movement/listview_dialog_finder.dart';

class ListviewDialogController extends StatelessWidget {
  final String inventoryName;

  const ListviewDialogController({super.key, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryLoadCubit, InventoryLoadState>(
      bloc: BlocProvider.of<InventoryLoadCubit>(context)
        ..loadInventory(inventoryName, ''),
      builder: (context, state) {
        if (state is LoadingState) {
          return Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const LinearProgressIndicator(), Container()],
          ));
        } else if (state is LoadedState) {
          return ListviewDialogFinder(
            listData: state.inventoryList,
          );
        } else if (state is ErrorState) {
          return Text(
            state.error,
            style: const TextStyle(color: Colors.red),
          );
        } else {
          return const Text(
            'Error de estado.',
            style: TextStyle(color: Colors.red),
          );
        }
      },
    );
  }
}
