import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/toolbar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../models/textfield_model.dart';
import '../../cubit/finder_notes_cubit.dart';
import '../../cubit/sale_note_cubit/salenote_cubit.dart';
import '../../cubit/salenote_drawer_cubit/salenote_drawer_cubit.dart';
import 'drawer_sale_note.dart';

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
              showDialog(
                context: context,
                builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(create: (_) => SalenoteDrawerCubit()),
                ], child: DrawerSalenote()),
              ).then((value) {});
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
              context.read<SalenoteCubit>().loadList();
              context
                  .read<FinderNotesCubit>()
                  .setState(TextfieldModel.initial());
            }
          },
        ),
      ],
    );
  }
}
