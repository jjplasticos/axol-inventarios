import 'package:axol_inventarios/plugins/movements/model/movement_filter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/warehouse_model.dart';
import '../../cubit/movement_filters/movement_filters_cubit.dart';

class DropdownWarehouses extends StatelessWidget {
  final MovementFilterModel filters;
  final List<WarehouseModel> warehouses;
  final WarehouseModel? currenWarehouse;

  const DropdownWarehouses(
      {super.key,
      required this.warehouses,
      this.currenWarehouse,
      required this.filters});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 40,
      child: DropdownButton(
        isExpanded: true,
        value: currenWarehouse,
        items: warehouses.map((e) {
          return DropdownMenuItem(value: e, child: Text(e.name));
        }).toList(),
        onChanged: (value) {
          context.read<MovementFiltersCubit>().changeWarehouse(filters, value);
        },
      ),
    );
  }
}
