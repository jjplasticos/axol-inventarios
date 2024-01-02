import 'dart:js';

import 'package:axol_inventarios/global_widgets/drawer_box.dart';
import 'package:axol_inventarios/plugins/sale/customer/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/alert_dialog_axol.dart';
import '../../../../global_widgets/textfield_input_form.dart';
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
          return loadDrawerBox(state.form, context);
        } else {
          return loadDrawerBox(form, context);
        }
      },
    );
  }

  DrawerBox loadDrawerBox(CustomerAddFormModel form, BuildContext context) {
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
        child: TextFieldInputForm(
          controller: element.controller,
          label: form.mapLbl[element.key],
          isLoading: element.isLoading,
          errorText: element.validation.isValid == false
              ? element.validation.errorMessage
              : null,
          onChanged: (value) {
            element.value = value;
            element.position = element.controller.selection.base.offset;
            listForm[i] = element;
            upForm = CustomerAddFormModel.listToForm(listForm);
            context.read<CustomerAddForm>().setForm(upForm);
          },
          onSubmitted: (value) {
            element.isLoading = true;
            listForm[i] = element;
            upForm = CustomerAddFormModel.listToForm(listForm);
            context.read<CustomerAddCubit>().loadSingleValidation(upForm, element.key);
          },
        ),
      );
      listWidget.add(widget);
    }
    drawerBox = DrawerBox(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      header: const Text(
        'Nuevo Cliente',
        style: Typo.subtitleDark,
      ),
      children: listWidget,
    );
    return drawerBox;
  }
}
