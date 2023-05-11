import 'package:flutter/material.dart';

import '../models/elemnets_bar_model.dart';

class PluginsBar extends StatelessWidget {
  final List<ElementsBarModel> listData;

  const PluginsBar({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: double.infinity,
      color: Colors.black54,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listData.length,
        itemBuilder: ((context, index) {
          final elementList = listData[index];
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
            child: IconButton(
              onPressed: elementList.action,
              icon: elementList.icon!,
              color: Colors.white70,
            ),
          );
        }),
      ),
    );
  }
}
