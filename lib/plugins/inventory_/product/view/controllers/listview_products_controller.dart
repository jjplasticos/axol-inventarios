import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/products/products_cubit.dart';
import '../../cubit/products/products_state.dart';
import '../widgets/finder_products.dart';
import '../widgets/listview_products.dart';
import '../widgets/toolbar_products.dart';

class ListviewProductsController extends StatelessWidget {
  const ListviewProductsController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      bloc: context.read<ProductsCubit>()..initialList(),
      builder: (context, state) {
        if (state is LoadingState) {
          return Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  FinderProducts(
                    mode: state.mode,
                    isLoading: true,
                    currentFinder: state.finder,
                  ),
                  const LinearProgressIndicator(),
                  const Expanded(child: SizedBox())
                ],
              )),
              ToolbarProducts(
                isLoading: true,
                mode: state.mode,
              ),
            ],
          );
        } else if (state is LoadedState) {
          return ListviewProducts(
            mode: state.mode,
            finder: state.finder,
            listData: state.products,
          );
        }
        return Container();
      },
    );
  }
}
