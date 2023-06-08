import 'package:axol_inventarios/models/warehouse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/user_mdoel.dart';
import '../../../../../settings/theme.dart';
import '../../../cubit/warehouse_setting/warehouse_setting_cubit.dart';
import '../../../cubit/warehouses_load/warehouses_load_cubit.dart';
import '../../controllers/drawer_warehouse_controller.dart';
import '../../views/warehouse_view.dart';

class ListviewWarehouseMenu extends StatelessWidget {
  final List<WarehouseModel> listData;
  final List<UserModel> users;
  final int mode;

  const ListviewWarehouseMenu(
      {super.key,
      required this.listData,
      required this.users,
      required this.mode});

  @override
  Widget build(BuildContext context) {
    Icon? icon;
    if (mode == 0) {
      //Navigate mode
      icon = const Icon(Icons.navigate_next, color: ColorPalette.primaryText);
    } else if (mode == 1) {
      //Edit mode
      icon = const Icon(Icons.edit, color: ColorPalette.primaryText);
    } else if (mode == 2) {
      //Delete mode
      icon =
          const Icon(Icons.highlight_remove, color: ColorPalette.primaryText);
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listData.length,
      itemBuilder: ((context, index) {
        final elementList = listData[index];
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
          child: SizedBox(
            height: 50,
            width: 300,
            child: OutlinedButton(
                onPressed: () {
                  if (mode == 0) {
                    //Navigate mode
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WarehouseView(
                                  warehouseName: elementList.name,
                                  users: users,
                                )));
                  } else if (mode == 1) {
                    //Edit mode
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
                                  settingMode: 1,
                                  users: users,
                                  widthDrawer: 500,
                                  currentWarehouse: elementList,
                                ),
                              ],
                            ))).then((value) {
                      context.read<WarehousesLoadCubit>().loadWarehouses(0);
                    });
                  } else if (mode == 2) {
                    //Delete mode
                    showDialog(
                      context: context,
                      builder: (context) => BlocProvider(
                          create: (_) => WarehouseSettingCubit(),
                          child: AlertDialog(
                            content: const Text(
                                '¿Estas seguro de elimnar este almacén?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar')),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  context
                                      .read<WarehouseSettingCubit>()
                                      .remove(elementList.id);
                                  //CallRemove().call(context, elementList);
                                },
                                child: const Text('Aceptar'),
                              )
                            ],
                          )),
                    ).then((value) {
                      context.read<WarehousesLoadCubit>().loadWarehouses(0);
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(elementList.name, style: Typo.bodyText5),
                    icon!,
                  ],
                )),
          ),
        );
      }),
    );
  }
}

class CallRemove {
  void call(BuildContext context, WarehouseModel elementList) {
    context.read<WarehouseSettingCubit>().remove(elementList.id);
  }
}
