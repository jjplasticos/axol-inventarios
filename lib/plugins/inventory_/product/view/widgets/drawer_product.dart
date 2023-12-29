import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/drawer_product/listen_drawer_cubit.dart';
import '../../model/product_model.dart';
import '../../cubit/drawer_product/drawer_product_cubit.dart';
import 'textfield_product.dart';

class DrawerProduct extends StatelessWidget {
  final ProductModel product;
  final List<Map<int, dynamic>> validation;
  final int mode;
  final bool finalValidation;
  final int currentFocus;
  final bool codeLoading;

  const DrawerProduct(
      {super.key,
      required this.product,
      required this.validation,
      required this.mode,
      required this.codeLoading,
      required this.finalValidation,
      required this.currentFocus});

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> textController = [];
    List<bool> isFocus = [];
    /*final List<String> propList = List.from(ProductModel.emptyValue().properties.keys);
    final Map<String, dynamic> properties = {};
    for (var element in propList) {
      if (product.properties.containsKey(element)) {
        properties[element] = product.properties[element];
      }
    }*/
    final List<dynamic> propertiesValues = List.from(product.properties!.values);
    for (int i = 0; i < propertiesValues.length; i++) {
      textController.add(TextEditingController());
      textController[i].text = propertiesValues[i].toString();
      if (currentFocus == i) {
        isFocus.add(true);
      } else {
        isFocus.add(false);
      }
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
                      TextfieldProductDB(
                        currentText: textController[0].text,
                        isFocus: isFocus[0],
                        position: 0,
                        product: product,
                        validation: validation,
                        isLoading: codeLoading,
                        label: 'Clave',
                        mode: mode,
                      ),
                      TextfieldProductString(
                        currentText: textController[1].text,
                        isFocus: isFocus[1],
                        label: 'Descripción:',
                        position: 1,
                        product: product,
                        tag: 'description',
                        validation: validation,
                      ),
                      TextfieldProductString(
                        currentText: textController[2].text,
                        isFocus: isFocus[2],
                        label: 'Tipo:',
                        position: 2,
                        product: product,
                        tag: 'type',
                        validation: validation,
                      ),
                      TextfieldProductString(
                        currentText: textController[3].text,
                        isFocus: isFocus[3],
                        label: 'Calibre:',
                        position: 3,
                        product: product,
                        tag: 'gauge',
                        validation: validation,
                      ),
                      TextfieldProductString(
                        currentText: textController[4].text,
                        isFocus: isFocus[4],
                        label: 'Piezas:',
                        position: 4,
                        product: product,
                        tag: 'pices',
                        validation: validation,
                      ),
                      TextfieldProductString(
                        currentText: textController[5].text,
                        isFocus: isFocus[5],
                        label: 'Peso:',
                        position: 5,
                        product: product,
                        tag: 'weight',
                        validation: validation,
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$')),
                        ],
                      ),
                      TextfieldProductString(
                        currentText: textController[6].text,
                        isFocus: isFocus[6],
                        label: 'Medida:',
                        position: 6,
                        product: product,
                        tag: 'measure',
                        validation: validation,
                      ),
                      TextfieldProductString(
                        currentText: textController[7].text,
                        isFocus: isFocus[7],
                        label: 'Empaque:',
                        position: 7,
                        product: product,
                        tag: 'packing',
                        validation: validation,
                      ),
                      TextfieldProductString(
                        currentText: textController[8].text,
                        isFocus: isFocus[8],
                        label: 'Capacidad:',
                        position: 8,
                        product: product,
                        tag: 'capacity',
                        validation: validation,
                      ),
                      TextfieldProductString(
                        currentText: textController[8].text,
                        isFocus: isFocus[8],
                        label: 'Clasificacion:',
                        position: 8,
                        product: product,
                        tag: 'class',
                        validation: validation,
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$')),
                        ],
                      ),
                    ],
                  )),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('Cancelar'),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          final currentProduct =
                              context.read<ListenProductCubit>().getProduct();
                          if (mode == 0) {
                            context
                                .read<DrawerProductCubit>()
                                .formValidation(
                                    currentProduct, validation, mode)
                                .then((value) {
                              if (value) {
                                context
                                    .read<DrawerProductCubit>()
                                    .insertProduct(currentProduct);
                                Navigator.pop(context, true);
                              }
                            });
                          } else if (mode == 1) {
                            context
                                .read<DrawerProductCubit>()
                                .formValidation(
                                    currentProduct, validation, mode)
                                .then((value) {
                              if (value) {
                                context
                                    .read<DrawerProductCubit>()
                                    .updateProduct(currentProduct);
                                Navigator.pop(context, true);
                              }
                            });
                          }
                        },
                        child: const Text('Guardar'),
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
