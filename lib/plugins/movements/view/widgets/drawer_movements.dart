import 'package:flutter/material.dart';
import '../../model/movement_filter_model.dart';
import 'dropdown_concepts.dart';
import 'dropdown_warehouses.dart';

class DrawerMovements extends StatelessWidget {
  final MovementFilterModel filters;
  const DrawerMovements({super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    String textDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          const Center(
            child: Text('Filtros'),
          ),
          Expanded(
              child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Almacén:'),
                  DropdownWarehouses(
                    warehouses: filters.warehousesList != null
                        ? filters.warehousesList!
                        : [],
                    currenWarehouse: filters.warehouse,
                    filters: filters,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Fecha:'),
                  Column(children: [
                    Text(textDate),
                    Row(
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((value) {
                                print(value);
                              });
                            },
                            child: const Text('Fecha')),
                        OutlinedButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                            },
                            child: const Text('Fecha inicial')),
                        OutlinedButton(
                            onPressed: () {
                              showDateRangePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                            },
                            child: const Text('Rango')),
                      ],
                    )
                  ]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Concepto:'),
                  DropdownConcepts(
                    concepts: filters.conceptsList ?? [],
                    currenConcept: filters.concept,
                    filters: filters,
                  ),
                ],
              ),
            ],
          )),
          Row(
            children: [
              OutlinedButton(onPressed: () {}, child: const Text('Aceptar')),
              OutlinedButton(onPressed: () {}, child: const Text('Cancelar'))
            ],
          )
        ],
      ),
    );
  }
}
