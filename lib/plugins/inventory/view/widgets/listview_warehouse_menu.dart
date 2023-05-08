import 'package:flutter/material.dart';

import '../../../../settings/theme.dart';
import '../views/warehouse_view.dart';

class ListviewWarehouseMenu extends StatelessWidget {
  final List<String> listData;

  const ListviewWarehouseMenu({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listData.length,
      itemBuilder: ((context, index) {
        final elementList = listData[index];
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
          child: SizedBox(
            height: 50,
            width: 300,
            child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WarehouseView()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(elementList, style: Typo.bodyText5),
                    const Icon(Icons.navigate_next,
                        color: ColorPalette.primaryText),
                  ],
                )),
          ),
        );
      }),
    );
  }
}
