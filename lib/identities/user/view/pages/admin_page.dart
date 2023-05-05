import 'package:flutter/material.dart';

import '../../model/user.dart';

class AdminPage extends StatelessWidget {
  final UserModel user;

  const AdminPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return const Text('Admin page');
  }
}
