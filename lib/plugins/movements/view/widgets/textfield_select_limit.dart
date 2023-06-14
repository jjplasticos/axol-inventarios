import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/movement_filters/movement_filters_cubit.dart';
import '../../model/movement_filter_model.dart';

class TextfieldSelectLimit extends StatelessWidget {
  final MovementFilterModel filter;
  //{'limit': int, 'position': int}

  const TextfieldSelectLimit({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    int? limit;
    int? position;
    TextEditingController textController = TextEditingController();
    bool isLimit;
    if (filter.currentLimit!.isEmpty) {
      isLimit = true;
      textController.text = '50';
    } else {
      limit = filter.currentLimit!['limit'];
      position = filter.currentLimit!['position'];
      isLimit = false;
      textController.value = TextEditingValue(
        text: limit.toString(),
        selection: TextSelection.collapsed(offset: position!),
      );
    }
    return Row(
      children: [
        Switch(
            value: isLimit,
            onChanged: (value) {
              if (value) {
                context.read<MovementFiltersCubit>().changeLimit(filter, -1, -1);
              } else {
                context.read<MovementFiltersCubit>().changeLimit(filter, int.tryParse(textController.text)! , textController.selection.base.offset);
              }
            }),
        SizedBox(
          width: 250,
          height: 40,
          child: TextField(
          controller: textController,
          onChanged: (value) {
            if (int.tryParse(value) != null) {
              context.read<MovementFiltersCubit>().changeLimit(filter, int.tryParse(value)!, textController.selection.base.offset);
            } 
          },
        ),
        ),
      ],
    );
  }
}
