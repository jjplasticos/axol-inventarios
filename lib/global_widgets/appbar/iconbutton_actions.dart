import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../settings/theme.dart';

class IconButtonActions extends StatelessWidget {
  final String data;

  const IconButtonActions({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final int action = int.parse(data.split('//').first);
    switch (action) {
      case 0:
        return const Text('');
      case 1:
      /*return IconButton(
            onPressed: () {
              context
                  .read<OptionsEditSaleCubit>()
                  .delete(data.split('//').last, 0, false);
            },
            icon: const Icon(
              Icons.delete,
              color: ColorPalette.primaryText,
              size: 30,
            ));*/
      default:
        return const Text('');
    }
  }
}
