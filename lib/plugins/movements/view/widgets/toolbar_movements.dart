import 'package:axol_inventarios/models/textfield_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/toolbar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../cubit/movement_filters/movement_filters_cubit.dart';
import '../../cubit/movements_view/movements_cubit.dart';
import '../../model/movement_filter_model.dart';
import '../controllers/drawer_movement_controller.dart';

class ToolbarMovements extends StatelessWidget {
  final bool isLoading;
  final MovementFilterModel currentFilter;
  const ToolbarMovements(
      {super.key, required this.isLoading, required this.currentFilter});

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
                    child: DrawerMovementsController(
                      currentFilter: currentFilter,
                    )),
              ).then((value) {
                if (value != null) {
                  //print(value);
                  context
                      .read<MovementsCuibit>()
                      .finderList(value, TextfieldModel(text: '', position: 0));
                }
              });
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
