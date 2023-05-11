import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/inventory_load/inventory_load_cubit.dart';
import '../../cubit/inventory_load/inventory_load_state.dart';
import '../widgets/warehouse/listview_warehouse.dart';

class ListviewWarehouseController extends StatelessWidget {
  final String warehouseName;

  const ListviewWarehouseController({super.key, required this.warehouseName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryLoadCubit, InventoryLoadState>(
      bloc: BlocProvider.of<InventoryLoadCubit>(context)
        ..loadInventory(warehouseName),
      builder: (context, state) {
        if (state is LoadingState) {
          return const LinearProgressIndicator();
        } else if (state is LoadedState) {
          return ListviewWarehouse(
            listData: state.inventoryList,
            warehouseName: '',
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
