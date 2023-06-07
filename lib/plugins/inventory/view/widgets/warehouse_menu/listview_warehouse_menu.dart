import 'package:axol_inventarios/models/warehouse_model.dart';
import 'package:flutter/material.dart';

import '../../../../../models/user_mdoel.dart';
import '../../../../../settings/theme.dart';
import '../../views/warehouse_view.dart';

class ListviewWarehouseMenu extends StatelessWidget {
  final List<WarehouseModel> listData;
  final List<UserModel> users;

  const ListviewWarehouseMenu(
      {super.key, required this.listData, required this.users});

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
                          builder: (context) => WarehouseView(
                                warehouseName: elementList.name,
                                users: users,
                              )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(elementList.name, style: Typo.bodyText5),
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
