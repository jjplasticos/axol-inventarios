import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/product_model.dart';
import '../../cubit/drawer_product/drawer_product_cubit.dart';

class DrawerAddProduct extends StatelessWidget {
  final ProductModel product;
  final List<Map<int, dynamic>> validation;
  final int mode;
  final bool finalValidation;
  final int currentFocus;

  const DrawerAddProduct(
      {super.key,
      required this.product,
      required this.validation,
      required this.mode,
      required this.finalValidation,
      required this.currentFocus});

  @override
  Widget build(BuildContext context) {
    //----Text Controllers y Focus Node
    List<bool> isError = [];
    List<FocusNode> focusNode = [];
    List<TextEditingController> textController = [];
    final List<dynamic> propertiesValues = List.from(product.properties.values);
    final List<dynamic> propertiesKeys = List.from(product.properties.keys);
    for (int i = 0; i < propertiesValues.length; i++) {
      focusNode.add(FocusNode());
      textController.add(TextEditingController());
      isError.add(false);
      textController[i].text = propertiesValues[i].toString();
      if (i == currentFocus) {
        focusNode[i].requestFocus();
      }
      focusNode[i].addListener(() {
        RawKeyEvent event;
        if (focusNode[i].hasFocus == true) {
          /*if (event is RawKeyDownEvent) {

          }
          if (event.logicalKey == LogicalKeyboardKey.keyR) {

          }*/
          if (i == 0) {
            context
                .read<DrawerProductCubit>()
                .codeValidation(textController[i].text, product, validation, i);
          } else {
            if (textController[i].text == '') {
              isError[i] = true;
            } else {
              isError[i] = false;
            }
            context.read<DrawerProductCubit>().singleValidation(
                textController[i].text,
                propertiesKeys[i],
                product,
                validation,
                isError[i],
                i);
          }
          focusNode[i].dispose();
          textController[i].dispose();
        }
      });
    }

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
                              focusNode: focusNode[0],
                              controller: textController[0],
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
                                    .codeValidation(
                                        value, product, validation, 0);
                              },
                              onChanged: (value) {
                                //textController.text = value;
                                textController[0].value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(
                                        offset: textController[0]
                                            .selection
                                            .base
                                            .offset));
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
                              focusNode: focusNode[1],
                              controller: textController[1],
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[1][0] ? null : validation[1][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                if (value == '') {
                                  isError[1] = true;
                                } else {
                                  isError[1] = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'description',
                                        product, validation, isError[1], 1);
                              },
                              onChanged: (value) {
                                textController[1].value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(
                                        offset: textController[1]
                                            .selection
                                            .base
                                            .offset));
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
                              focusNode: focusNode[2],
                              controller: textController[2],
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[2][0] ? null : validation[2][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                if (value == '') {
                                  isError[2] = true;
                                } else {
                                  isError[2] = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'type', product,
                                        validation, isError[2], 2);
                              },
                              onChanged: (value) {
                                textController[2].value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(
                                        offset: textController[2]
                                            .selection
                                            .base
                                            .offset));
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
                              focusNode: focusNode[3],
                              controller: textController[3],
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[3][0] ? null : validation[3][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                if (value == '') {
                                  isError[3] = true;
                                } else {
                                  isError[3] = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'gauge', product,
                                        validation, isError[3], 3);
                              },
                              onChanged: (value) {
                                textController[3].value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(
                                        offset: textController[3]
                                            .selection
                                            .base
                                            .offset));
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
                              focusNode: focusNode[4],
                              controller: textController[4],
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[4][0] ? null : validation[4][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                if (value == '') {
                                  isError[4] = true;
                                } else {
                                  isError[4] = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'pices', product,
                                        validation, isError[4], 4);
                              },
                              onChanged: (value) {
                                textController[4].value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(
                                        offset: textController[4]
                                            .selection
                                            .base
                                            .offset));
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
                              focusNode: focusNode[5],
                              controller: textController[5],
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[5][0] ? null : validation[5][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                if (value == '' ||
                                    double.tryParse(value) == null) {
                                  isError[5] = true;
                                } else {
                                  isError[5] = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'weight', product,
                                        validation, isError[5], 5);
                              },
                              onChanged: (value) {
                                textController[5].value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(
                                        offset: textController[5]
                                            .selection
                                            .base
                                            .offset));
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
                              focusNode: focusNode[6],
                              controller: textController[6],
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[6][0] ? null : validation[6][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                if (value == '') {
                                  isError[6] = true;
                                } else {
                                  isError[6] = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'measure', product,
                                        validation, isError[6], 6);
                              },
                              onChanged: (value) {
                                textController[6].value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(
                                        offset: textController[6]
                                            .selection
                                            .base
                                            .offset));
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
                              focusNode: focusNode[7],
                              controller: textController[7],
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[7][0] ? null : validation[7][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                if (value == '') {
                                  isError[7] = true;
                                } else {
                                  isError[7] = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'packing', product,
                                        validation, isError[7], 7);
                              },
                              onChanged: (value) {
                                textController[7].value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(
                                        offset: textController[7]
                                            .selection
                                            .base
                                            .offset));
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
                              focusNode: focusNode[8],
                              controller: textController[8],
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: const TextStyle(height: 0.3),
                                errorText:
                                    validation[8][0] ? null : validation[8][1],
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                              onSubmitted: (value) {
                                if (value == '') {
                                  isError[8] = true;
                                } else {
                                  isError[8] = false;
                                }
                                context
                                    .read<DrawerProductCubit>()
                                    .singleValidation(value, 'capacity',
                                        product, validation, isError[8], 8);
                              },
                              onChanged: (value) {
                                textController[8].value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.collapsed(
                                        offset: textController[8]
                                            .selection
                                            .base
                                            .offset));
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
