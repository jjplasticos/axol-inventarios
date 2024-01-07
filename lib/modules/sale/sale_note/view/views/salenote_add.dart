import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaleNoteAdd extends StatelessWidget {
  const SaleNoteAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: bloc,
      builder: builder,
      listener: listener,
    );
  }
}
