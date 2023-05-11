import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/warehouses_load/warehouses_load_cubit.dart';
import '../../cubit/warehouses_load/wareshouses_load_state.dart';
import '../widgets/warehouse_menu/listview_warehouse_menu.dart';

class ListviewWHMenuController extends StatelessWidget {
  const ListviewWHMenuController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WarehousesLoadCubit, WarehousesLoadState>(
      bloc: BlocProvider.of<WarehousesLoadCubit>(context)..loadWarehouses(),
      builder: (context, state) {
        if (state is LoadingState) {
          return const LinearProgressIndicator();
        } else if (state is LoadedState) {
          return ListviewWarehouseMenu(listData: state.names);
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
