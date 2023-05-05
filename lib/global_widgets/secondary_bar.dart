import 'package:flutter/material.dart';

class SecondaryBar extends StatelessWidget {
  final List<Map<String, dynamic>> listData;

  const SecondaryBar({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: double.infinity,
      color: Colors.black45,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listData.length,
        itemBuilder: ((context, index) {
          final elementList = listData[index];
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
            child: Text(elementList.toString()),
          );
        }),
      ),
    );
  }
}
