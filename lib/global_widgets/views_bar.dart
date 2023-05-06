import 'package:flutter/material.dart';

import '../models/viewsbar_model.dart';

class ViewsBar extends StatelessWidget {
  final List<ViewsbarModel> listData;

  const ViewsBar({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: double.infinity,
      color: Colors.black45,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listData.length,
        itemBuilder: ((context, index) {
          final elementList = listData[index];
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: elementList.icon,
              label: Text(elementList.text,
                  style: TextStyle(color: Colors.white54)),
              style: ButtonStyle(
                  iconColor: MaterialStatePropertyAll(Colors.white54)),
            ),
          );
        }),
      ),
    );
  }
}
