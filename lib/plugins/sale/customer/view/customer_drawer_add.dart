import 'package:axol_inventarios/global_widgets/drawer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/textfield_input_form.dart';
import '../../../../utilities/theme.dart';
import '../cubit/customer_add/customer_add_form.dart';
import '../model/customer_add_form_model.dart';

class CustomerDrawerAdd extends StatelessWidget {
  const CustomerDrawerAdd({super.key});

  @override
  Widget build(BuildContext context) {
    CustomerAddFormModel form = context.read<CustomerAddForm>().state;
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerPhoneNumber = TextEditingController();
    TextEditingController controllerRfc = TextEditingController();
    TextEditingController controllerPostalCode = TextEditingController();
    TextEditingController controllerIntNumber = TextEditingController();
    TextEditingController controllerOutNumber = TextEditingController();
    TextEditingController controllerStreet = TextEditingController();
    TextEditingController controllerHood = TextEditingController();
    TextEditingController controllerTown = TextEditingController();
    TextEditingController controllerCountry = TextEditingController();
    controllerName.value = TextEditingValue(
        text: form.name.value,
        selection: TextSelection.collapsed(offset: form.name.position));
    controllerId.value = TextEditingValue(
        text: form.id.value,
        selection: TextSelection.collapsed(offset: form.id.position));
    controllerPhoneNumber.value = TextEditingValue(
        text: form.phoneNumber.value,
        selection: TextSelection.collapsed(offset: form.phoneNumber.position));
    controllerRfc.value = TextEditingValue(
        text: form.rfc.value,
        selection: TextSelection.collapsed(offset: form.rfc.position));
    controllerPostalCode.value = TextEditingValue(
        text: form.postalCode.value,
        selection: TextSelection.collapsed(offset: form.postalCode.position));
    controllerIntNumber.value = TextEditingValue(
        text: form.intNumber.value,
        selection: TextSelection.collapsed(offset: form.intNumber.position));
    controllerOutNumber.value = TextEditingValue(
        text: form.outNumber.value,
        selection: TextSelection.collapsed(offset: form.outNumber.position));
    controllerStreet.value = TextEditingValue(
        text: form.street.value,
        selection: TextSelection.collapsed(offset: form.street.position));
    controllerHood.value = TextEditingValue(
        text: form.hood.value,
        selection: TextSelection.collapsed(offset: form.hood.position));
    controllerTown.value = TextEditingValue(
        text: form.town.value,
        selection: TextSelection.collapsed(offset: form.town.position));
    controllerCountry.value = TextEditingValue(
        text: form.country.value,
        selection: TextSelection.collapsed(offset: form.country.position));

    return DrawerBox(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      header: const Text(
        'Nuevo Cliente',
        style: Typo.subtitleDark,
      ),
      children: [
        Material(
          child: TextFieldInputForm(
            label: 'Id: ',
            controller: controllerId,
            errorText: form.id.validation.isValid == false
                ? form.id.validation.errorMessage
                : null,
          ),
        ),
        Material(
          child: TextFieldInputForm(
            label: 'Nombre: ',
            controller: controllerName,
            errorText: form.name.validation.isValid == false
                ? form.name.validation.errorMessage
                : null,
          ),
        ),
        Material(
          child: TextFieldInputForm(
            label: 'Telefono: ',
            controller: controllerPhoneNumber,
            errorText: form.phoneNumber.validation.isValid == false
                ? form.phoneNumber.validation.errorMessage
                : null,
          ),
        ),
        Material(
          child: TextFieldInputForm(
            label: 'RFC: ',
            controller: controllerRfc,
            errorText: form.rfc.validation.isValid == false
                ? form.rfc.validation.errorMessage
                : null,
          ),
        ),
        Material(
          child: TextFieldInputForm(
            label: 'Código postal: ',
            controller: controllerPostalCode,
            errorText: form.postalCode.validation.isValid == false
                ? form.postalCode.validation.errorMessage
                : null,
          ),
        ),
        Material(
          child: TextFieldInputForm(
            label: 'Número interior: ',
            controller: controllerIntNumber,
            errorText: form.intNumber.validation.isValid == false
                ? form.intNumber.validation.errorMessage
                : null,
          ),
        ),
        Material(
          child: TextFieldInputForm(
            label: 'Número exterior: ',
            controller: controllerOutNumber,
            errorText: form.outNumber.validation.isValid == false
                ? form.outNumber.validation.errorMessage
                : null,
          ),
        ),
        Material(
          child: TextFieldInputForm(
            label: 'Calle: ',
            controller: controllerStreet,
            errorText: form.street.validation.isValid == false
                ? form.street.validation.errorMessage
                : null,
          ),
        ),
        Material(
          child: TextFieldInputForm(
            label: 'Colonia: ',
            controller: controllerHood,
            errorText: form.hood.validation.isValid == false
                ? form.hood.validation.errorMessage
                : null,
          ),
        ),
        Material(
          child: TextFieldInputForm(
            label: 'Ciudad: ',
            controller: controllerTown,
            errorText: form.town.validation.isValid == false
                ? form.town.validation.errorMessage
                : null,
          ),
        ),
        Material(
          child: TextFieldInputForm(
            label: 'Estado: ',
            controller: controllerCountry,
            errorText: form.country.validation.isValid == false
                ? form.country.validation.errorMessage
                : null,
          ),
        ),
      ],
    );
  }
}
