import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utilities/theme/theme.dart';
import '../../cubit/inventory_load/inventory_load_cubit.dart';
import '../../cubit/textfield_finder_invrow_cubit.dart';

class TextfieldFinderInventroyrow extends StatelessWidget {
  final String inventoryName;
  final bool? isWithStock;

  const TextfieldFinderInventroyrow(
      {super.key, required this.inventoryName, this.isWithStock});

  @override
  Widget build(BuildContext context) {
    final txtValue = context.watch<TextfieldFinderInvrowCubit>().state;
    final controller = TextEditingController()
      ..text = txtValue
      ..selection = TextSelection.collapsed(offset: txtValue.length);

    return Container(
      color: ColorPalette.lightBackground,
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
                  if (isWithStock == null || isWithStock == true) {
                    context
                        .read<InventoryLoadCubit>()
                        .loadInventory(inventoryName, value);
                  } else {
                    context.read<InventoryLoadCubit>().findProducts(value);
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Buscar',
                    hintStyle: Typo.hintText,
                    filled: true,
                    fillColor: ColorPalette.lightBackground,
                    border: InputBorder.none),
                style: Typo.textField1,
              ),
            ),
          ),
          IconButton(
            iconSize: 30,
            color: ColorPalette.darkText,
            icon: const Icon(
              Icons.close,
            ),
            onPressed: () {
              context.read<TextfieldFinderInvrowCubit>().clear();
              if (isWithStock == null || isWithStock == true) {
                context
                    .read<InventoryLoadCubit>()
                    .loadInventory(inventoryName, '');
              } else {
                context.read<InventoryLoadCubit>().loadProducts();
              }
            },
          )
        ],
      ),
    );
  }
}
