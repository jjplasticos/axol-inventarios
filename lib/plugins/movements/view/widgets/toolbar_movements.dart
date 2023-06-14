import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/toolbar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../cubit/movement_filters/movement_filters_cubit.dart';
import '../controllers/drawer_movement_controller.dart';

class ToolbarMovements extends StatelessWidget {
  final bool isLoading;
  const ToolbarMovements({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Toolbar(
      listData: [
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.add),
          action: () {},
        ),
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.filter_alt),
          action: () {
            if (isLoading == false) {
              showDialog(
                context: context,
                builder: (context) => BlocProvider(
                    create: (_) => MovementFiltersCubit(),
                    child: const DrawerMovementsController()),
              );
            }
          },
        ),
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.restart_alt),
          action: () {},
        )
      ],
    );
  }
}
