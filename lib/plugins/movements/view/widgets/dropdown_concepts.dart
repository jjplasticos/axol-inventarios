import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/inventory_move_concept_model.dart';
import '../../cubit/movement_filters/movement_filters_cubit.dart';
import '../../model/movement_filter_model.dart';

class DropdownConcepts extends StatelessWidget {
  final MovementFilterModel filters;
  final List<InventoryMoveConceptModel> concepts;
  final InventoryMoveConceptModel? currenConcept;

  const DropdownConcepts(
      {super.key,
      required this.concepts,
      this.currenConcept,
      required this.filters});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 40,
      child: DropdownButton(
        isExpanded: true,
        value: currenConcept,
        items: concepts.map((e) {
          return DropdownMenuItem(value: e, child: Text(e.concept));
        }).toList(),
        onChanged: (value) {
          context.read<MovementFiltersCubit>().changeConcept(filters, value);
        },
      ),
    );
  }
}
