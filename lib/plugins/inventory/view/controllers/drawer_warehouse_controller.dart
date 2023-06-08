import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_mdoel.dart';
import '../../../../models/warehouse_model.dart';
import '../../cubit/warehouse_setting/warehouse_setting_cubit.dart';
import '../../cubit/warehouse_setting/warehouse_setting_state.dart';
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
    if (settingMode == 0) {
      //add mode
      userSelect = null;
      currentName = '';
    } else if (settingMode == 1) {
      //edit mode
      userSelect = currentWarehouse!.retailManager;
      currentName = currentWarehouse!.name;
      if (userSelect == '') {
        userSelect = null;
      }
    }
    return BlocConsumer<WarehouseSettingCubit, WarehouseSettingState>(
      bloc: context.read<WarehouseSettingCubit>()
        ..change(userSelect, currentName, 0),
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
            userSelected: state.userSelected,
            currentWarehouse: currentWarehouse,
            currentName: state.currentName,
            widthDrawer: widthDrawer,
            txtPosition: state.txtPosition,
          );
        } else {
          return Container();
        }
      },
      listener: (context, state) {
        if (state is LoadedState) {
          Navigator.pop(context);
        }
        if (state is EditState) {
          if (state.error == true) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(state.message!),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Aceptar'))
                ],
              ),
            );
          }
        }
        if (state is RemoveLoadedState) {
          print('RemoveLoadedState');
        }
      },
    );
  }
}
