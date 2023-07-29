import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../models/textfield_form_model.dart';

class TextfieldRc extends StatelessWidget {
  final String label;
  final List<TextInputFormatter>? inputFormatter;
  final int keyFormElement;
  final bool isFocus;

  const TextfieldRc(
      {super.key,
      required this.label,
      this.inputFormatter,
      required this.keyFormElement,
      required this.isFocus});

  @override
  Widget build(BuildContext context) {
    //SalenoteFormModel currentForm;
    TextEditingController textController = TextEditingController();
    FocusNode focusNode = FocusNode();
    SalenoteFormModel form = context.read<SalenoteFormCubit>().state;
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        SizedBox(
            height: 40,
            width: 300,
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
                /*currentForm = context.read<SalenoteFormCubit>().state;
                  context
                      .read<SalenoteDrawerCubit>()
                      .change(currentForm, keyFormElement);*/
              },
              onChanged: (value) {
                /*context.read<SalenoteFormCubit>().change(
                        value,
                        textController.selection.base.offset,
                        keyFormElement,
                      );*/
              },
            ))
      ],
    );
  }
}
