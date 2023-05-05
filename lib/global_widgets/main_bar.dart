import 'package:axol_inventarios/settings/theme.dart';
import 'package:flutter/material.dart';

class MainBar extends StatelessWidget {
  const MainBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: double.infinity,
      color: Colors.black45,
      child: Column(
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home, color: Colors.white70)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.inventory, color: Colors.white70)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.note, color: Colors.white70)),
        ],
      ),
    );
  }
}
