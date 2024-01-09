import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../../utilities/theme/theme.dart';
import '../../cubit/salenote_add/salenote_add_cubit.dart';
import '../../cubit/salenote_add/salenote_add_state.dart';

class SaleNoteAdd extends StatelessWidget {
  const SaleNoteAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SaleNoteAddCubit, SaleNoteAddState>(
      bloc: context.read<SaleNoteAddCubit>()..load(),
      builder: (context, state) {
        if (state is LoadingSaleNoteAddState) {
          
        } else if (state is LoadedSaleNoteAddState) {

        } else {}
      },
      listener: (context, state) {
        if (state is ErrorSaleNoteAddState) {

        }
      },
    );
  }

  Widget saleNoteAdd(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.darkBackground,
      appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarGlobal(
              title: 'Nota de venta',
              iconButton: null,
              iconActions: [],
            ),
          ),
      body: Row(),
    );
  }
}
