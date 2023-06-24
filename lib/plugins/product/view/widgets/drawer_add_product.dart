import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/product_model.dart';
import '../../cubit/drawer_product/drawer_product_cubit.dart';

class DrawerAddProduct extends StatelessWidget {
  final ProductModel product;
  final Map<int, dynamic> validationCode;

  const DrawerAddProduct(
      {super.key, required this.product, required this.validationCode});

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
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Center(
                    child: Text('Nuevo producto'),
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Clave:'),
                          Visibility(
                            visible: !validationCode[0],
                            child: const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              isDense: true,
                              errorStyle: const TextStyle(height: 0.3),
                              errorText:
                                  validationCode[0] ? null : validationCode[1],
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                            ),
                            onSubmitted: (value) {
                              context
                                  .read<DrawerProductCubit>()
                                  .codeValidation(value, product);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Descripción:'), TextField()],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Tipo:'), TextField()],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Calibre:'), TextField()],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Piezas:'), TextField()],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Peso:'), TextField()],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Medida:'), TextField()],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Empaque:'), TextField()],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Capacidad:'), TextField()],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Usuario encargado:'),
                          TextField()
                        ],
                      ),
                    ],
                  )),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }
}
