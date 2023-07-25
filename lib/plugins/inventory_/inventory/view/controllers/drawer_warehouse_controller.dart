import 'package:axol_inventarios/models/textfield_model.dart';
import 'package:axol_inventarios/models/validation_form_model.dart';
import 'package:axol_inventarios/plugins/inventory/model/warehouse_stream_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_mdoel.dart';
import '../../model/warehouse_model.dart';
import '../../cubit/warehouse_setting/warehouse_setting_cubit.dart';
import '../../cubit/warehouse_setting/warehouse_setting_state.dart';
import '../../cubit/warehouse_stream_cubit.dart';
import '../widgets/warehouse_menu/drawer_warehouse.dart';

class DrawerWarehouseController extends StatelessWidget {
  final List<UserModel> users;
  final int settingMode;
  final WarehouseModel? currentWarehouse;
  final double widthDrawer;

  const DrawerWarehouseController(
      {super.key,
      required this.users,
      required this.settingMode,
      this.currentWarehouse,
      required this.widthDrawer});

  @override
  Widget build(BuildContext context) {
    String? userSelect;
    String currentName = '';
    String currentId = '';
    WarehouseSettingCubit cubit = context.read<WarehouseSettingCubit>()
      ..initialToAdd();
    if (settingMode == 0) {
      //add mode
      userSelect = null;
      currentName = '';
      currentId = '';
    } else if (settingMode == 1) {
      //edit mode
      userSelect = currentWarehouse!.retailManager;
      currentName = currentWarehouse!.name;
      currentId = currentWarehouse!.id.toString();
      if (userSelect == '') {
        userSelect = null;
      }
    } else if (settingMode == 3) {
      //remove mode
      cubit = context.read<WarehouseSettingCubit>()
        ..openAlert(currentWarehouse!.id);
    }
    return BlocConsumer<WarehouseSettingCubit, WarehouseSettingState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is LoadingState) {
          return Drawer(
            width: widthDrawer,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                  child: LinearProgressIndicator(),
                ),
                Expanded(child: Container()),
              ],
            ),
          );
        } else if (state is EditState) {
          return DrawerWarehouse(
            users: users,
            settingMode: settingMode,
            currentWarehouse: currentWarehouse,
            widthDrawer: widthDrawer,
          );
        } else if (state is RemoveAlertState) {
          return AlertDialog(
            content: const Text('¿Desea elimnar este almacén?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar')),
              TextButton(
                onPressed: () {
                  context.read<WarehouseSettingCubit>().remove(state.id);
                },
                child: const Text('Aceptar'),
              )
            ],
          );
        } else if (state is RemoveLoadingState) {
          return const AlertDialog(
            content: LinearProgressIndicator(),
            backgroundColor: Colors.transparent,
          );
        } else {
          return Container();
        }
      },
      listener: (context, state) {
        if (state is LoadedState) {
          Navigator.pop(context);
        }
        if (state is EditState) {}
        if (state is RemoveLoadedState) {
          Navigator.pop(context);
        }
      },
    );
  }
}
