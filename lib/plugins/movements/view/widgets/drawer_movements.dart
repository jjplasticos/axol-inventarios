import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/movement_filters/movement_filters_cubit.dart';
import '../../model/movement_filter_model.dart';
import 'dropdown_warehouses.dart';

class DrawerMovements extends StatelessWidget {
  final MovementFilterModel filters;
  const DrawerMovements({super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    DateTime timeNow = DateTime.now();
    String textDate = filters.date.toString();
    bool allDates;
    if (filters.date == null) {
      allDates = true;
      textDate = 'HASTA HOY';
    } else {
      allDates = false;
    }
    return Padding(
      padding: const EdgeInsets.all(8),
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
                                if (value != null) {
                                  textDate =
                                      '${value.day}/${value.month}/${value.year}';
                                  context
                                      .read<MovementFiltersCubit>()
                                      .changeDate(filters, textDate);
                                }
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
                              ).then((value) {
                                if (value != null) {
                                  textDate =
                                      '${value.day}/${value.month}/${value.year} -> ${timeNow.day}/${timeNow.month}/${timeNow.year}';
                                  context
                                      .read<MovementFiltersCubit>()
                                      .changeDate(filters, textDate);
                                }
                              });
                            },
                            child: const Text('Fecha inicial')),
                        OutlinedButton(
                            onPressed: () {
                              showDateRangePicker(
                                context: context,
                                firstDate: DateTime(DateTime.now().year - 10),
                                lastDate: DateTime.now(),
                              ).then((value) {
                                if (value != null) {
                                  textDate =
                                      '${value.start.day}/${value.start.month}/${value.start.year} -> ${value.end.day}/${value.end.month}/${value.end.year}';
                                  context
                                      .read<MovementFiltersCubit>()
                                      .changeDate(filters, textDate);
                                }
                              });
                            },
                            child: const Text('Rango')),
                        Switch(
                            value: allDates,
                            onChanged: (value) {
                              if (value) {
                                context
                                    .read<MovementFiltersCubit>()
                                    .changeDate(filters, null);
                              } else {
                                textDate =
                                    '${timeNow.day}/${timeNow.month}/${timeNow.year}';
                                context
                                    .read<MovementFiltersCubit>()
                                    .changeDate(filters, textDate);
                              }
                            }),
                      ],
                    )
                  ]),
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
