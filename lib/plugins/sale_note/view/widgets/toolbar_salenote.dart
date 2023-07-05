import 'package:flutter/material.dart';

import '../../../../global_widgets/toolbar.dart';
import '../../../../models/elemnets_bar_model.dart';

class ToolbarSaleNote extends StatelessWidget {
  final bool isLoading;

  const ToolbarSaleNote({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Toolbar(
      listData: [
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.add),
          action: () {
            if (isLoading == false) {
              /*showDialog(
                context: context,
                builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => DrawerProductCubit()),
                      BlocProvider(
                          create: (_) => ListenProductCubit(
                              initialProduct: ProductModel.emptyValue())),
                    ],
                    child: DrawerProductController(
                      mode: mode,
                      initialProduct: ProductModel.emptyValue(),
                    )),
              ).then((value) {
                if (value == true) {
                  context.read<ProductsCubit>().reloadList(
                      const TextfieldModel(text: '', position: 0), 0);
                }
              });*/
            }
          },
        ),
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.restart_alt),
          action: () {
            if (isLoading == false) {
              //context.read<ProductsCubit>().initialList();
            }
          },
        ),
      ],
    );
  }
}
