import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/textfield_model.dart';
import '../../../../../models/user_mdoel.dart';
import '../../../../../models/validation_form_model.dart';
import '../../../../../models/warehouse_model.dart';
import '../../../cubit/warehouse_setting/warehouse_setting_cubit.dart';

class DrawerWarehouse extends StatelessWidget {
  final List<UserModel> users;
  final int settingMode;
  final WarehouseModel? currentWarehouse;
  final String? userSelected;
  final double widthDrawer;
  final TextfieldModel textfieldName;
  final TextfieldModel textfieldId;
  final List<ValidationFormModel> validation;

  const DrawerWarehouse(
      {super.key,
      required this.users,
      required this.settingMode,
      this.currentWarehouse,
      this.userSelected,
      required this.widthDrawer,
      required this.textfieldName,
      required this.textfieldId,
      required this.validation});

  @override
  Widget build(BuildContext context) {
    WarehouseModel warehouseEdited;
    TextEditingController textController = TextEditingController();
    TextEditingController textController2 = TextEditingController();
    textController.value = TextEditingValue(
        text: textfieldName.text,
        selection: TextSelection.collapsed(offset: textfieldName.position));
    textController2.value = TextEditingValue(
      text: textfieldId.text,
      selection: TextSelection.collapsed(offset: textfieldId.position),
    );
    print(validation[0].isValid);
    return Drawer(
      width: widthDrawer,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          const Center(
            child: Text('Titulo de drawer'),
          ),
          Expanded(
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Número de almacén:'),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          errorStyle: const TextStyle(height: 0.3),
                          errorText: validation[0].isValid
                              ? null
                              : validation[0].errorMessage,
                          errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                        controller: textController2,
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          context.read<WarehouseSettingCubit>().change(
                                userSelected,
                                TextfieldModel(
                                  text: textController.text,
                                  position:
                                      textController.selection.base.offset,
                                ),
                                TextfieldModel(
                                  text: value,
                                  position:
                                      textController2.selection.base.offset,
                                ),
                                validation,
                                0,
                              );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nombre de almacén'),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          isDense: true,
                          errorStyle: const TextStyle(height: 0.3),
                          errorText: validation[1].isValid
                              ? null
                              : validation[1].errorMessage,
                          errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          context.read<WarehouseSettingCubit>().change(
                                userSelected,
                                TextfieldModel(
                                  text: value,
                                  position:
                                      textController.selection.base.offset,
                                ),
                                TextfieldModel(
                                  text: textController2.text,
                                  position:
                                      textController2.selection.base.offset,
                                ),
                                validation,
                                1,
                              );
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
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: userSelected,
                        items: users.map((element) {
                          return DropdownMenuItem<String>(
                              value: element.name, child: Text(element.name));
                        }).toList(),
                        onChanged: (value) {
                          context.read<WarehouseSettingCubit>().change(
                                value,
                                TextfieldModel(
                                  text: textController.text,
                                  position:
                                      textController.selection.base.offset,
                                ),
                                TextfieldModel(
                                  text: textController2.text,
                                  position:
                                      textController2.selection.base.offset,
                                ),
                              );
                        },
                      ),
                    )
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
                  /*if (settingMode == 0) {
                    //add mode
                    if (userSelected == null ||
                        textfieldName.text == '' ||
                        textfieldId.text == '') {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Alerta!'),
                          content:
                              const Text('Llene los campos correspondeintes'),
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
                      context.read<WarehouseSettingCubit>().add(
                          textfieldId,
                          textfieldName,
                          userSelected!,);
                    }
                  } else if (settingMode == 1) {
                    //edit mode
                    warehouseEdited = WarehouseModel(
                        id: currentWarehouse!.id,
                        name: textController.text,
                        retailManager: userSelected!);
                    if (userSelected == null || textfieldName.text == '') {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Alerta!'),
                          content: const Text(
                              'Seleccione un encargado de almacén y llene el campo de nombre'),
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
                          .edit(warehouseEdited);
                    }
                  }*/
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
