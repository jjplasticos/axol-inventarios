import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../settings/theme.dart';
import '../../cubit/list_view_invmov_cubit.dart';
import '../controllers/listview_invmov_controller.dart';

class InventoryMovementView extends StatelessWidget {
  const InventoryMovementView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'Menú de almacenes';

    return MultiBlocProvider(
        providers: [
          //BlocProvider(create: (_) => WarehousesLoadCubit()),
          BlocProvider(create: (_) => ListviewInvMovCubit()),
        ],
        child: const Scaffold(
          backgroundColor: ColorPalette.primaryBackground,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarGlobal(
              title: title,
              iconButton: null,
              iconActions: [],
            ),
          ),
          body: ListviewInvMovController(),
        ));
  }
}
