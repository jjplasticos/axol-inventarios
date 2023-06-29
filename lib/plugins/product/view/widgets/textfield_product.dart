import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/drawer_product/drawer_product_cubit.dart';
import '../../model/product_model.dart';

class TextfieldProductDB extends StatelessWidget {
  final String currentText;
  final ProductModel product;
  final List<Map<int, dynamic>> validation;
  //final FocusNode focusNode;
  final bool isFocus;
  final bool isLoading;
  final int position;
  final String label;
  final String? tag;

  const TextfieldProductDB(
      {super.key,
      required this.currentText,
      required this.product,
      required this.validation,
      //required this.focusNode,
      required this.position,
      required this.isLoading,
      required this.label,
      this.tag,
      required this.isFocus});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    textController.text = currentText;
    FocusNode focusNode = FocusNode();
    final int nextFocus = position + 1;
    focusNode.addListener(() {
      if (focusNode.hasFocus == false) {
        context.read<DrawerProductCubit>().codeValidation(
            textController.text, product, validation, nextFocus);
      }
    });
    if (isFocus) {
      focusNode.requestFocus();
    }
    focusNode.canRequestFocus = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Visibility(
          visible: isLoading,
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
                  validation[position][0] ? null : validation[position][1],
              errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
            ),
            onSubmitted: (value) {
              focusNode.nextFocus();
              context
                  .read<DrawerProductCubit>()
                  .codeValidation(value, product, validation, nextFocus);
              focusNode.unfocus();
            },
            onChanged: (value) {
              textController.value = TextEditingValue(
                  text: value,
                  selection: TextSelection.collapsed(
                      offset: textController.selection.base.offset));
            },
          ),
        ),
      ],
    );
  }
}

class TextfieldProductString extends StatelessWidget {
  final String currentText;
  final ProductModel product;
  final List<Map<int, dynamic>> validation;
  //final FocusNode focusNode;
  final bool isFocus;
  final int position;
  final String label;
  final String tag;

  const TextfieldProductString(
      {super.key,
      required this.currentText,
      required this.product,
      required this.validation,
      //required this.focusNode,
      required this.position,
      required this.label,
      required this.tag,
      required this.isFocus});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    textController.text = currentText;
    FocusNode focusNode = FocusNode();
    bool isError = false;
    final int nextFocus = position + 1;
    focusNode.addListener(() {
      if (focusNode.hasFocus == false) {
        if (textController.text == '') {
          isError = true;
        } else {
          isError = false;
        }
        context.read<DrawerProductCubit>().singleValidation(textController.text,
            tag, product, validation, isError, position, nextFocus);
      }
    });
    if (isFocus) {
      focusNode.requestFocus();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
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
                    validation[position][0] ? null : validation[position][1],
                errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
              ),
              onSubmitted: (value) {
                if (value == '') {
                  isError = true;
                } else {
                  isError = false;
                }
                context.read<DrawerProductCubit>().singleValidation(value, tag,
                    product, validation, isError, position, nextFocus);
                focusNode.unfocus();
              },
              onChanged: (value) {
                textController.value = TextEditingValue(
                    text: value,
                    selection: TextSelection.collapsed(
                        offset: textController.selection.base.offset));
              },
            ))
      ],
    );
  }
}
