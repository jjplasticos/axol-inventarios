import 'package:flutter/material.dart';

import '../models/elemnets_bar_model.dart';

class Toolbar extends StatelessWidget {
  final List<ElementsBarModel> listData;

  const Toolbar({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: double.infinity,
      color: Colors.black45,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listData.length,
        itemBuilder: ((context, index) {
          final elementList = listData[index];
          final Color color;
          if (elementList.secondaryColor != null) {
            color = elementList.secondaryColor!;
          } else {
            color = Colors.white54;
          }
          return Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
              child: IconButton(
                onPressed: elementList.action,
                icon: elementList.icon!,
                color: color,
              ));
        }),
      ),
    );
  }
}
