import 'package:flutter/material.dart';

class DrawerSalenote extends StatelessWidget {
  const DrawerSalenote({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          color: Colors.black26,
        )),
        Drawer(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Center(
                  child: Text('Nueva nota'),
                ),
                Expanded(
                    child: ListView(
                  children: [],
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
