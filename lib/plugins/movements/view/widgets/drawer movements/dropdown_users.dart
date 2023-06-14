import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/user_mdoel.dart';
import '../../../cubit/movement_filters/movement_filters_cubit.dart';
import '../../../model/movement_filter_model.dart';

class DropdownUsers extends StatelessWidget {
  final MovementFilterModel filters;
  final List<UserModel> users;
  final UserModel? currentUser;

  const DropdownUsers(
      {super.key,
      required this.users,
      this.currentUser,
      required this.filters});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 40,
      child: DropdownButton(
        isExpanded: true,
        value: currentUser,
        items: users.map((e) {
          return DropdownMenuItem(value: e, child: Text(e.name));
        }).toList(),
        onChanged: (value) {
          context.read<MovementFiltersCubit>().changeUser(filters, value);
        },
      ),
    );
  }
}
