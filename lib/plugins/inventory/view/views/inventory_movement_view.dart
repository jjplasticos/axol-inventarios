import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../global_widgets/toolbar.dart';
import '../../../../global_widgets/views_bar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../settings/theme.dart';
import '../../cubit/warehouses_load/warehouses_load_cubit.dart';

class InventoryMovementView extends StatelessWidget {
  const InventoryMovementView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'Menú de almacenes';

    return BlocProvider(
      create: (_) => WarehousesLoadCubit(),
      child: Scaffold(
        backgroundColor: ColorPalette.primaryBackground,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarGlobal(
            title: title,
            iconButton: null,
            iconActions: [],
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewsBar(
                listData: [
                  ElementsBarModel(
                      icon: const Icon(Icons.arrow_back),
                      text: 'Regresar',
                      action: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              Expanded(
                child: Column(
                  children: const [],
                ),
              ),
              Toolbar(
                listData: [
                  ElementsBarModel(
                    text: null,
                    icon: const Icon(Icons.add),
                    action: () {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
