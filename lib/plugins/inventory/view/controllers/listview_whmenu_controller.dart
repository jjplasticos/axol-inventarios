import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/toolbar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../cubit/warehouse_setting/warehouse_setting_cubit.dart';
import '../../cubit/warehouses_load/warehouses_load_cubit.dart';
import '../../cubit/warehouses_load/wareshouses_load_state.dart';
import '../widgets/warehouse_menu/listview_warehouse_menu.dart';
import 'drawer_warehouse_controller.dart';

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
          return Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListviewWarehouseMenu(
                    listData: state.warehouses,
                    users: state.users,
                  ),
                ),
              ),
              Toolbar(
                listData: [
                  ElementsBarModel(
                      text: null,
                      icon: const Icon(Icons.add),
                      action: () {
                        showDialog(
                            context: context,
                            builder: (context) => BlocProvider(
                                create: (_) => WarehouseSettingCubit(),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      color: Colors.black26,
                                    )),
                                    DrawerWarehouseController(
                                      settingMode: 0,
                                      users: state.users,
                                      widthDrawer: 500,
                                    ),
                                  ],
                                )));
                      }),
                  ElementsBarModel(
                    text: null,
                    icon: const Icon(Icons.edit_square),
                    action: () {},
                  ),
                  ElementsBarModel(
                    text: null,
                    icon: const Icon(Icons.delete),
                    action: () {},
                  )
                ],
              ),
            ],
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
