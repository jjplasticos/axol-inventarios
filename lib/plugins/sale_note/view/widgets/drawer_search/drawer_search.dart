import 'package:axol_inventarios/plugins/sale_note/model/customer_model.dart';
import 'package:flutter/material.dart';

import 'listview_search_customer.dart';

class DrawerSearch extends StatelessWidget {
  final bool isLoading;
  final List<CustomerModel> listData;
  const DrawerSearch(
      {super.key, required this.isLoading, required this.listData});

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
          child: Column(
            children: [
              Visibility(visible: isLoading, child: LinearProgressIndicator()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Center(
                        child: Text('Busqueda de '),
                      ),
                      Expanded(
                          child: ListView(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Row(
                            children: [
                              Expanded(child: TextField()),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.search)),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.cancel)),
                            ],
                          ),
                          ListviewSearchCustomer(listData: listData),
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
