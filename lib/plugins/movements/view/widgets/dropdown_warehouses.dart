import 'package:flutter/material.dart';

class DropdownWarehouses extends StatelessWidget {
  const DropdownWarehouses({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: null /*Inventario actual a mostrar */,
      items: [/* Lista con nombres de inventarios o id */].map((e) {
        return DropdownMenuItem(value: e, child: Text(e));
      }).toList(),
      onChanged: (value) {
        //Elemento seleccionado, mostrar en value de Dropdown
      },
    );
  }
}
