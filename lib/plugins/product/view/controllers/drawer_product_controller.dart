import 'package:axol_inventarios/plugins/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/drawer_product/drawer_product_cubit.dart';
import '../../cubit/drawer_product/drawer_product_state.dart';
import '../widgets/drawer_add_product.dart';

class DrawerProductController extends StatelessWidget {

  const DrawerProductController({super.key});

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
          child: BlocBuilder<DrawerProductCubit, DrawerProductState>(
            bloc: context.read<DrawerProductCubit>()..initialDrawer(ProductModel.emptyValue(), 9),
            builder: (context, state) {
              if (state is LoadingState) {
                return const Column(
                  children: [
                    LinearProgressIndicator(),
                    Expanded(child: SizedBox())
                  ],
                );
              } else if (state is LoadedState) {
                return DrawerAddProduct(product: state.product, validation: state.validation, mode: state.mode, finalValidation: state.finalValidation,);
              } else if (state is LoadingCodeState) {
                return DrawerAddProduct(product: state.product, validation: state.validationCode, mode: state.mode, finalValidation: false,);
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