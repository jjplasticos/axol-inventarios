import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/toolbar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../cubit/drawer_product/drawer_product_cubit.dart';
import '../../cubit/products/products_cubit.dart';
import '../controllers/drawer_product_controller.dart';

class ToolbarProducts extends StatelessWidget {
  final bool isLoading;
  const ToolbarProducts({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Toolbar(
      listData: [
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.add),
          action: () {
            if (isLoading == false) {
              showDialog(
                context: context,
                builder: (context) => BlocProvider(
                    create: (_) => DrawerProductCubit(),
                    child: const DrawerProductController()),
              );
            }
          },
        ),
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.edit_square),
          action: () {
            if (isLoading == false) {}
          },
        ),
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.delete),
          action: () {
            if (isLoading == false) {}
          },
        ),
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.restart_alt),
          action: () {
            if (isLoading == false) {
              context.read<ProductsCubit>().initialList();
            }
          },
        ),
      ],
    );
  }
}
