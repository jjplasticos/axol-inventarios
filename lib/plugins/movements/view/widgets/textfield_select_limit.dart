import 'package:flutter/material.dart';

class TextfieldSelectLimit extends StatelessWidget {
  const TextfieldSelectLimit({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /*Switch(
            value: allDates,
            onChanged: (value) {
              if (value) {
                context.read<MovementFiltersCubit>().changeDate(filters, null);
              } else {
                textDate = '${timeNow.day}/${timeNow.month}/${timeNow.year}';
                context
                    .read<MovementFiltersCubit>()
                    .changeDate(filters, textDate);
              }
            }),*/
      ],
    );
  }
}
