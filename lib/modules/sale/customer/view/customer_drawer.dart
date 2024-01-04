import 'package:axol_inventarios/modules/sale/customer/cubit/customer_tab/customer_tab_cubit.dart';
import 'package:axol_inventarios/utilities/widgets/alert_dialog_axol.dart';
import 'package:axol_inventarios/utilities/widgets/button.dart';
import 'package:axol_inventarios/utilities/widgets/drawer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/theme.dart';
import '../model/customer_model.dart';

class CustomerDrawer extends StatelessWidget {
  final CustomerModel customer;

  const CustomerDrawer({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return DrawerBox(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      header: const Text(
        'Cliente',
        style: Typo.subtitleDark,
      ),
      actions: [
        ButtonReturn(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ButtonDelete(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) =>  AlertDialogAxol(
                text:
                    '¿Estás seguro de eliminar este cliente?\n Esta acción no se podrá desasear',
                    actions: [
                      ButtonReturn(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      ButtonDelete(
                        onPressed: () {
                          context.read<CustomerTabCubit>().deleteCustomer(customer);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      ),
                    ],
              ),
            );
          },
        ),
      ],
      children: [
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Id: ',
                style: Typo.bodyDark,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                customer.id.toString(),
                style: Typo.bodyDark,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Nombre: ',
                style: Typo.bodyDark,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                customer.name,
                style: Typo.bodyDark,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Telefono: ',
                style: Typo.bodyDark,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                '${customer.phoneNumber ?? ''}',
                style: Typo.bodyDark,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'RFC: ',
                style: Typo.bodyDark,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                customer.rfc ?? '',
                style: Typo.bodyDark,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Código postal: ',
                style: Typo.bodyDark,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                customer.postalCode ?? '',
                style: Typo.bodyDark,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Número interno: ',
                style: Typo.bodyDark,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                '${customer.intNumber ?? ''}',
                style: Typo.bodyDark,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Número externo: ',
                style: Typo.bodyDark,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                '${customer.outNumber ?? ''}',
                style: Typo.bodyDark,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Calle: ',
                style: Typo.bodyDark,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                customer.street ?? '',
                style: Typo.bodyDark,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Colonia: ',
                style: Typo.bodyDark,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                customer.hood ?? '',
                style: Typo.bodyDark,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Ciudad: ',
                style: Typo.bodyDark,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                customer.town ?? '',
                style: Typo.bodyDark,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'Estado: ',
                style: Typo.bodyDark,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                customer.country ?? '',
                style: Typo.bodyDark,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
