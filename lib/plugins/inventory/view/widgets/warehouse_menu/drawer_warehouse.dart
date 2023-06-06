import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/user_mdoel.dart';
import '../../../../../models/warehouse_model.dart';
import '../../../cubit/warehouse_setting/warehouse_setting_cubit.dart';

class DrawerWarehouse extends StatelessWidget {
  final List<UserModel> users;
  final int settingMode;
  final WarehouseModel? currentWarehouse;
  final String? userSelected;

  const DrawerWarehouse(
      {super.key,
      required this.users,
      required this.settingMode,
      this.currentWarehouse,
      this.userSelected});

  @override
  Widget build(BuildContext context) {
    WarehouseModel warehouseEdited;
    TextEditingController textController = TextEditingController();
    if (settingMode == 0) {
      //Add mode
    } else if (settingMode == 1) {
      //Edit mode
      textController.text = currentWarehouse!.name;
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Nombre de almacén'),
            TextField(
              controller: textController,
              onChanged: (value) {
                textController.text = value;
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Encargado de almacén'),
            DropdownButton<String>(
              value: userSelected,
              items: users.map((element) {
                return DropdownMenuItem<String>(
                    value: element.name, child: Text(element.name));
              }).toList(),
              onChanged: (value) {
                context.read<WarehouseSettingCubit>().change(value);
              },
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.canPop(context);
              },
              child: const Text('Cancelar'),
            ),
            OutlinedButton(
              onPressed: () {
                if (settingMode == 0) {
                  //add mode
                  if (userSelected == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Alerta!'),
                        content:
                            const Text('Seleccione un encargado de almacén'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Aceptar'))
                        ],
                      ),
                    );
                  } else {
                    context
                        .read<WarehouseSettingCubit>()
                        .add(textController.text, userSelected!);
                  }
                } else if (settingMode == 1) {
                  //edit mode
                  warehouseEdited = WarehouseModel(
                      id: currentWarehouse!.id,
                      name: textController.text,
                      retailManager: userSelected!);
                  context.read<WarehouseSettingCubit>().edit(warehouseEdited);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ]),
    );
  }
}
