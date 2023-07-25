import 'package:flutter/material.dart';

import '../../controllers/listview_dialog_controller.dart';
import '../textfield_finder_inventoryrow.dart';

class DialogSearchProduct extends StatelessWidget {
  final String inventoryName;

  const DialogSearchProduct({super.key, required this.inventoryName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Buscador
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.keyboard_arrow_left),
              ),
              Expanded(
                  child: TextfieldFinderInventroyrow(
                      inventoryName: inventoryName)),
            ],
          ),

          //Lista de busqueda
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('Clave'),
              Text('Descripción'),
              Text('Stock'),
              Text('')
            ],
          ),
          ListviewDialogController(
            inventoryName: inventoryName,
          ),
        ],
      ),
    );
  }
}
