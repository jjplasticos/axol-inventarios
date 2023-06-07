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
    return Drawer(
      width: 500,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Center(
            child: Text('Titulo de drawer'),
          ),
          Expanded(
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nombre de almacén'),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        controller: textController,
                        onChanged: (value) {
                          textController.text = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
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
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
