import 'package:flutter/material.dart';

class DrawerAddRc extends StatelessWidget {
  final bool isLoading;

  const DrawerAddRc({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          color: Colors.black26,
        )),
        Drawer(
          width: 600,
          child: Column(
            children: [
              Visibility(visible: isLoading, child: LinearProgressIndicator()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Center(
                        child: Text('Nueva nota'),
                      ),
                      Expanded(
                          child: ListView(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          // ignore: prefer_const_constructors
                          /*TextfieldSalenote(
                            label: 'Cliente',
                            keyFormElement: 0,
                            isFocus: false,
                          ),
                          // ignore: prefer_const_constructors
                          TextfieldSalenote(
                            label: 'Vendor',
                            keyFormElement: 1,
                            isFocus: false,
                          ),
                          // ignore: prefer_const_constructors
                          TextfieldSalenote(
                            label: 'Warehouse',
                            keyFormElement: 2,
                            isFocus: false,
                          ),*/
                        ],
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
