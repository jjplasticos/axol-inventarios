import 'package:flutter/material.dart';

import '../../model/product_model.dart';

class DrawerDetailsProduct extends StatelessWidget {
  final ProductModel product;

  const DrawerDetailsProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          color: Colors.black26,
        )),
        Drawer(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Center(
                    child: Text('Detalles de producto'),
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Clave:'),
                          Text(product.code),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Descripción:'),
                          Text(product.description),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tipo:'),
                          Text(product.properties[ProductModel.propType]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Calibre:'),
                          Text(product.properties[ProductModel.propGauge]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Piezas:'),
                          Text(product.properties[ProductModel.propPieces]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Peso:'),
                          Text(product.properties[ProductModel.propWeight]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Medida:'),
                          Text(product.properties[ProductModel.propMeasure]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Empaque:'),
                          Text(product.properties[ProductModel.propPacking]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Capacidad:'),
                          Text(product.properties[ProductModel.propCapacity]),
                        ],
                      ),
                    ],
                  )),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }
}
