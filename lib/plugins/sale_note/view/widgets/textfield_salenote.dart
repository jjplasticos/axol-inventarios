import 'package:axol_inventarios/models/textfield_model.dart';
import 'package:axol_inventarios/plugins/sale_note/model/saelnote_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/textfield_form_model.dart';
import '../../cubit/salenote_form_cubit.dart';

class TextfieldSalenote extends StatelessWidget {
  final String label;
  final List<TextInputFormatter>? inputFormatter;
  final int keyFormElement;
  final bool isFocus;

  const TextfieldSalenote(
      {super.key,
      required this.label,
      this.inputFormatter,
      required this.keyFormElement,
      required this.isFocus});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    FocusNode focusNode = FocusNode();
    SalenoteFormModel form = SalenoteFormCubit().state;
    TextfieldFormModel formElement = TextfieldFormModel.initial();
    if (keyFormElement == 0) {
      formElement = form.customer;
    } else if (keyFormElement == 1) {
      formElement = form.vendor;
    } else if (keyFormElement == 2) {
      formElement = form.warehouse;
    }
    textController.value = TextEditingValue(
        text: formElement.value,
        selection: TextSelection.collapsed(offset: formElement.position));
    if (isFocus) {
      focusNode.requestFocus();
    }
    return Row(
      children: [
        Text(label),
        SizedBox(
          height: 40,
          width: 250,
          child: TextField(
            inputFormatters: inputFormatter,
            focusNode: focusNode,
            controller: textController,
            decoration: InputDecoration(
              isDense: true,
              errorStyle: const TextStyle(height: 0.3),
              errorText: formElement.validation.isValid
                  ? null
                  : formElement.validation.errorMessage,
              errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
            ),
            onSubmitted: (value) {
              /*final currentProduct =
                  context.read<ListenProductCubit>().getProduct();
              if (value == '') {
                isError = true;
              } else {
                isError = false;
              }
              context.read<DrawerProductCubit>().singleValidation(value, tag,
                  currentProduct, validation, isError, position, nextFocus);
              focusNode.unfocus();*/
            },
            onChanged: (value) {
              context.read<SalenoteFormCubit>().change(
                    value,
                    textController.selection.base.offset,
                    keyFormElement,
                  );
              /*textController.value = TextEditingValue(
                  text: value,
                  selection: TextSelection.collapsed(
                      offset: textController.selection.base.offset));
              final currentProduct =
                  context.read<ListenProductCubit>().getProduct();
              //print(currentProduct.properties);
              context
                  .read<ListenProductCubit>()
                  .change(currentProduct, position, value);*/
            },
          ),
        )
      ],
    );
  }
}
