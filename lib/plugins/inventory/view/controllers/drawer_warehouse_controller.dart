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

  const DrawerWarehouseController(
      {super.key,
      required this.users,
      required this.settingMode,
      this.currentWarehouse});

  @override
  Widget build(BuildContext context) {
    String? userSelect;
    if (settingMode == 0) {
      //add mode
      userSelect = null;
    } else if (settingMode == 1) {
      //edit mode
      userSelect = currentWarehouse!.retailManager;
    }
    return BlocConsumer<WarehouseSettingCubit, WarehouseSettingState>(
      bloc: context.read<WarehouseSettingCubit>()..change(userSelect),
      builder: (context, state) {
        if (state is LoadingState) {
          return const LinearProgressIndicator();
        } else if (state is EditState) {
          return DrawerWarehouse(
            users: users,
            settingMode: settingMode,
            userSelected: state.userSelected,
            currentWarehouse: currentWarehouse,
          );
        } else {
          return Container();
        }
      },
      listener: (context, state) {
        if (state is LoadedState) {
          Navigator.pop(context);
        }
      },
    );
  }
}
