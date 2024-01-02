import 'package:axol_inventarios/modules/inventory_/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/drawer_product/drawer_product_cubit.dart';
import '../../cubit/drawer_product/drawer_product_state.dart';
import '../widgets/drawer_product.dart';

class DrawerProductController extends StatelessWidget {
  final int mode;
  final ProductModel initialProduct;

  const DrawerProductController(
      {super.key, required this.mode, required this.initialProduct});

  @override
  Widget build(BuildContext context) {
    DrawerProductCubit? drawerProductCubit;
    if (mode == 0) {
      drawerProductCubit = context.read<DrawerProductCubit>()
        ..initialDrawer(initialProduct, 9, 0);
    } else if (mode == 1) {
      drawerProductCubit = context.read<DrawerProductCubit>()
        ..initialDrawer(initialProduct, 9, 0);
    }
    return Row(
      children: [
        Expanded(
            child: Container(
          color: Colors.black26,
        )),
        Drawer(
          width: 500,
          child: BlocBuilder<DrawerProductCubit, DrawerProductState>(
            bloc: drawerProductCubit,
            builder: (context, state) {
              if (state is LoadingState) {
                return const Column(
                  children: [
                    LinearProgressIndicator(),
                    Expanded(child: SizedBox())
                  ],
                );
              } else if (state is LoadedState) {
                return DrawerProduct(
                  product: state.product,
                  validation: state.validation,
                  mode: mode,
                  codeLoading: false,
                  finalValidation: state.finalValidation,
                  currentFocus: state.currentFocus,
                );
              } else if (state is LoadingCodeState) {
                return DrawerProduct(
                  product: state.product,
                  validation: state.validationCode,
                  mode: mode,
                  codeLoading: true,
                  finalValidation: false,
                  currentFocus: state.currentFocus,
                );
              } else if (state is ErrorState) {
                return Text(state.error);
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}

/*class DrawerProductListenController extends StatelessWidget {
  const DrawerProductListenController({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          color: Colors.black26,
        )),
        Drawer(
          width: 500,
          child: BlocListener<ListenProductCubit, ProductModel>(
            bloc: context.read<ListenProductCubit>(),
            listener: (context, state) {
              
            },
            //poner en child el widget que se requiere envolver con BlocListener
            child: const DrawerProductController(),
          ),
        ),
      ],
    );
  }
}*/
