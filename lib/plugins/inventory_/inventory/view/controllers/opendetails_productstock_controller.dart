import 'package:axol_inventarios/plugins/inventory_/inventory/cubit/show_details_product_stock/showdetails_productstock_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/show_details_product_stock/showdetails_productstock_cubit.dart';
import '../widgets/dialog_productinfo.dart';

class OpenDetailsProductStockController extends StatelessWidget {
  final String code;
  final String inventoryName;

  const OpenDetailsProductStockController(
      {super.key, required this.code, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowDetailsProductStockCubit, ShowDetailsProductStock>(
      bloc: context.read<ShowDetailsProductStockCubit>()
        ..openDetails(code, inventoryName),
      builder: (context, state) {
        if (state is OpenDetailsLoadingState) {
          return const Dialog(
              child: SizedBox(
            width: 400,
            height: 5,
            child: LinearProgressIndicator(),
          ));
        } else if (state is OpenDetailsLoadedState) {
          if (state.inventoryRow != null) {
            return DialogProductInfo(inventoryRow: state.inventoryRow!);
          } else {
            return const Dialog(
              child: SizedBox(
                width: 400,
                height: 200,
                child: Text('inventoryRow == null'),
              ),
            );
          }
        } else if (state is ErrorState) {
          return Dialog(
            child: SizedBox(
              width: 400,
              height: 200,
              child: Text(state.error),
            ),
          );
        } else {
          return const Dialog(
            child: SizedBox(
              width: 400,
              height: 200,
              child: Text('No recibio estado'),
            ),
          );
        }
      },
    );
  }
}
