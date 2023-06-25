import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/product_model.dart';
import '../../cubit/drawer_product/drawer_product_cubit.dart';

class DrawerAddProduct extends StatelessWidget {
  final ProductModel product;
  final List<Map<int, dynamic>> validation;
  final int mode;
  final bool finalValidation;

  const DrawerAddProduct(
      {super.key,
      required this.product,
      required this.validation,
      required this.mode,
      required this.finalValidation});

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    TextEditingController textController = TextEditingController();
    textController.text = product.code;
    focusNode.addListener(
      () {
        if (!focusNode.hasFocus) {
          context
              .read<DrawerProductCubit>()
              .codeValidation(textController.text, product, validation);
        }
      },
    );
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
                            visible: mode == 1,
                            child: const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 250,
                            child: TextField(
                              focusNode: focusNode,
                              controller: textController,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[0][0] ? null : validation[0][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                context
                                    .read<DrawerProductCubit>()
                                    .codeValidation(value, product, validation);
                              },
                              onChanged: (value) {
                                //textController.text = value;
                                textController.value = TextEditingValue(text: value, selection: TextSelection.collapsed(offset: textController.selection.base.offset));
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Descripción:'),
                          SizedBox(
                            height: 40,
                            width: 250,
                            child: TextField(
                              //focusNode: focusNode,
                              controller: TextEditingController(),
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[1][0] ? null : validation[1][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                final bool isError;
                                if (value == '') {
                                  isError = true;
                                } else {
                                  isError = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'description',
                                        product, validation, isError, 1);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tipo:'),
                          SizedBox(
                            height: 40,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[2][0] ? null : validation[2][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                final bool isError;
                                if (value == '') {
                                  isError = true;
                                } else {
                                  isError = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'type', product,
                                        validation, isError, 2);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Calibre:'),
                          SizedBox(
                            height: 40,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[3][0] ? null : validation[3][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                final bool isError;
                                if (value == '') {
                                  isError = true;
                                } else {
                                  isError = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'gauge', product,
                                        validation, isError, 3);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Piezas:'),
                          SizedBox(
                            height: 40,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[4][0] ? null : validation[4][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                final bool isError;
                                if (value == '') {
                                  isError = true;
                                } else {
                                  isError = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'pices', product,
                                        validation, isError, 4);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Peso:'),
                          SizedBox(
                            height: 40,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[5][0] ? null : validation[5][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                final bool isError;
                                if (value == '' ||
                                    double.tryParse(value) == null) {
                                  isError = true;
                                } else {
                                  isError = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'weight', product,
                                        validation, isError, 5);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Medida:'),
                          SizedBox(
                            height: 40,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[6][0] ? null : validation[6][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                final bool isError;
                                if (value == '') {
                                  isError = true;
                                } else {
                                  isError = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'measure', product,
                                        validation, isError, 6);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Empaque:'),
                          SizedBox(
                            height: 40,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[7][0] ? null : validation[7][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                final bool isError;
                                if (value == '') {
                                  isError = true;
                                } else {
                                  isError = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'packing', product,
                                        validation, isError, 7);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Capacidad:'),
                          SizedBox(
                            height: 40,
                            width: 250,
                            child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[8][0] ? null : validation[8][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                final bool isError;
                                if (value == '') {
                                  isError = true;
                                } else {
                                  isError = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'capacity',
                                        product, validation, isError, 8);
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          context
                              .read<DrawerProductCubit>()
                              .formValidation(product, validation)
                              .then((value) {
                            if (value) {
                              Navigator.pop(context);
                            }
                          });
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
