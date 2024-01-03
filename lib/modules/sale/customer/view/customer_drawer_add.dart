import 'package:axol_inventarios/utilities/widgets/drawer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/widgets/alert_dialog_axol.dart';
import '../../../../utilities/widgets/button.dart';
import '../../../../utilities/widgets/progress_indicator.dart';
import '../../../../utilities/widgets/textfield_input_form.dart';
import '../../../../models/textfield_form_model.dart';
import '../../../../utilities/theme.dart';
import '../cubit/customer_add/customer_add_cubit.dart';
import '../cubit/customer_add/customer_add_form.dart';
import '../cubit/customer_add/customer_add_state.dart';
import '../model/customer_add_form_model.dart';

class CustomerDrawerAdd extends StatelessWidget {
  const CustomerDrawerAdd({super.key});

  @override
  Widget build(BuildContext context) {
    CustomerAddFormModel form = context.read<CustomerAddForm>().state;

    return BlocConsumer<CustomerAddCubit, CustomerAddState>(
      bloc: context.read<CustomerAddCubit>()..loadAvailableId(form),
      listener: (context, state) {
        if (state is ErrorCustomerAddState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialogAxol(text: state.error),
          );
        }
        if (state is SavedCustomerAddState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        form = context.read<CustomerAddForm>().state;
        if (state is LoadedCustomerAddState) {
          return loadDrawerBox(state.form, context, false);
        } else if (state is LoadingCustomerAddState) {
          return loadDrawerBox(form, context, true);
        } else {
          return loadDrawerBox(form, context, false);
        }
      },
    );
  }

  DrawerBox loadDrawerBox(
      CustomerAddFormModel form, BuildContext context, bool isLoading) {
    CustomerAddFormModel upForm = form;
    List<TextfieldFormModel> listForm = CustomerAddFormModel.formToList(form);
    List<Widget> listWidget = [];
    Material widget;
    DrawerBox drawerBox;
    for (int i = 0; i < listForm.length; i++) {
      var element = listForm[i];
      element.controller.value = TextEditingValue(
          text: element.value,
          selection: TextSelection.collapsed(offset: element.position));
      widget = Material(
        child: Focus(
            onFocusChange: (value) {
              if (value == false && upForm.currentFocusKey != element.key) {
                //element.isLoading = true;
                //listForm[i] = element;
                //upForm = CustomerAddFormModel.listToForm(listForm, upForm.currentFocusKey);
                context
                    .read<CustomerAddCubit>()
                    .loadSingleValidation(upForm, element.key, upForm.currentFocusKey);
              } else if (value && upForm.currentFocusKey != element.key) {
                context.read<CustomerAddForm>().setCurrentFocus(element.key);
                context.read<CustomerAddCubit>().load(upForm);
              }
              print('${element.key}: $value');
              print(upForm.currentFocusKey);
            },
            child: TextFieldInputForm(
              controller: element.controller,
              label: form.mapLbl[element.key],
              enabled: !isLoading,
              focusNode: element.focusNode,
              errorText: element.validation.isValid == false
                  ? element.validation.errorMessage
                  : null,
              onChanged: (value) {
                element.value = value;
                element.position = element.controller.selection.base.offset;
                listForm[i] = element;
                upForm = CustomerAddFormModel.listToForm(listForm, upForm.currentFocusKey);
                context.read<CustomerAddForm>().setForm(upForm);
              },
              onSubmitted: (value) {
                element.isLoading = true;
                listForm[i] = element;
                upForm = CustomerAddFormModel.listToForm(listForm, upForm.currentFocusKey);
                context
                    .read<CustomerAddCubit>()
                    .loadSingleValidation(upForm, element.key, upForm.currentFocusKey);
              },
            )),
      );
      listWidget.add(widget);
    }
    drawerBox = DrawerBox(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
      header: Column(
        children: [
          const Text(
            'Nuevo Cliente',
            style: Typo.subtitleDark,
          ),
          Visibility(
              visible: isLoading,
              replacement: const SizedBox(
                height: 4,
              ),
              child: const LinearProgressIndicatorAxol())
        ],
      ),
      actions: const [
        ButtonDrawerReturn(),
        SizedBox(
          width: 16,
        ),
        ButtonDrawerSave(),
      ],
      children: listWidget,
    );
    return drawerBox;
  }
}
