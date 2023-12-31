import 'package:flutter/material.dart';

import '../../../../customer/model/customer_model.dart';

class ListviewSearchCustomer extends StatelessWidget {
  final List<CustomerModel> listData;

  const ListviewSearchCustomer({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listData.length,
      itemBuilder: (context, index) {
        final customer = listData[index];
        return Container(
          height: 100,
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black38),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text(customer.id.toString()), Text(customer.name)],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('RFC: ${customer.rfc}'),
                      Text('Calle: ${customer.street}'),
                      Text('Número externo: ${customer.outNumber}'),
                      Text('Número interno: ${customer.intNumber}'),
                      Text('Colonia: ${customer.hood}')
                    ],
                  ),
                  Column(
                    children: [
                      Text('Código postal: ${customer.postalCode}'),
                      Text('Ciudad: ${customer.town}'),
                      Text('Estado: ${customer.country}'),
                      Text('Número de telefono: ${customer.phoneNumber}')
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
