import 'package:axol_inventarios/plugins/sale_note/view/widgets/textfield_salenote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/salenote_form_cubit.dart';

class DrawerSalenote extends StatelessWidget {
  const DrawerSalenote({super.key});

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
                  child: Text('Nueva nota'),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    const TextfieldSalenote(
                      label: 'Cliente',
                      keyFormElement: 0,
                      isFocus: false,
                    ),
                    const TextfieldSalenote(
                      label: 'Vendor',
                      keyFormElement: 1,
                      isFocus: false,
                    ),
                    const TextfieldSalenote(
                      label: 'Warehouse',
                      keyFormElement: 2,
                      isFocus: false,
                    ),
                    const Divider(),
                    const Center(
                      child: Text('Cliente'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                        'Id: {context.read<SalenoteFormCubit>().state.customerModel.id}'),
                    Text(
                        'Nombre: {context.read<SalenoteFormCubit>().state.customerModel.name}'),
                    Text(
                        'RFC: {context.read<SalenoteFormCubit>().state.customerModel.rfc}'),
                    Text(
                        'Calle: {context.read<SalenoteFormCubit>().state.customerModel.street}'),
                    Text(
                        'Número externo: {context.read<SalenoteFormCubit>().state.customerModel.outNumber}'),
                    Text(
                        'Numero interno: {context.read<SalenoteFormCubit>().state.customerModel.intNumber}'),
                    Text(
                        'Colonia: {context.read<SalenoteFormCubit>().state.customerModel.hood}'),
                    Text(
                        'Código postal: {context.read<SalenoteFormCubit>().state.customerModel.postalCode}'),
                    Text(
                        'Ciudad: {context.read<SalenoteFormCubit>().state.customerModel.town}'),
                    Text(
                        'Estado: {context.read<SalenoteFormCubit>().state.customerModel.country}'),
                    Text(
                        'Número de telefono: {context.read<SalenoteFormCubit>().state.customerModel.phoneNumber}'),
                    const Divider(),
                    const Center(
                      child: Text('Vendedor'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                        'Id: {context.read<SalenoteFormCubit>().state.vendorModel.id}'),
                    Text(
                        'Nombre: {context.read<SalenoteFormCubit>().state.vendorModel.name}'),
                    const Divider(),
                    const Center(
                      child: Text('Almacén'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                        'Id: {context.read<SalenoteFormCubit>().state.warehouseModel.id}'),
                    Text(
                        'Nombre: {context.read<SalenoteFormCubit>().state.warehouseModel.name}'),
                    Text(
                        'Encargado: {context.read<SalenoteFormCubit>().state.warehouseModel.retailManager}'),
                    const Divider(),
                  ],
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
