import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../settings/theme.dart';
import '../../cubit/inventory_load/inventory_load_cubit.dart';
import '../../cubit/textfield_finder_invrow_cubit.dart';

class TextfieldFinderInventroyrow extends StatelessWidget {
  final String inventoryName;

  const TextfieldFinderInventroyrow({super.key, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    final txtValue = context.watch<TextfieldFinderInvrowCubit>().state;
    final controller = TextEditingController()
      ..text = txtValue
      ..selection = TextSelection.collapsed(offset: txtValue.length);

    return Container(
      color: ColorPalette.secondaryBackground,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: TextFormField(
                controller: controller,
                autofocus: false,
                obscureText: false,
                onChanged: (value) {
                  context.read<TextfieldFinderInvrowCubit>().change(value);
                  context
                      .read<InventoryLoadCubit>()
                      .loadInventory(inventoryName, value);
                },
                decoration: InputDecoration(
                    hintText: 'Buscar',
                    hintStyle: Typo.hintText,
                    filled: true,
                    fillColor: ColorPalette.secondaryBackground,
                    border: InputBorder.none),
                style: Typo.textField1,
              ),
            ),
          ),
          IconButton(
            iconSize: 30,
            color: ColorPalette.secondaryText,
            icon: const Icon(
              Icons.cancel,
            ),
            onPressed: () {
              context.read<TextfieldFinderInvrowCubit>().clear();
              context
                  .read<InventoryLoadCubit>()
                  .loadInventory(inventoryName, '');
            },
          )
        ],
      ),
    );
  }
}
