import 'package:flutter/material.dart';

import '../../model/product_model.dart';
import '../../../../models/textfield_model.dart';
import '../../../../settings/theme.dart';
import 'drawer_details_product.dart';
import 'finder_products.dart';
import 'toolbar_products.dart';

class ListviewProducts extends StatelessWidget {
  final List<ProductModel> listData;
  final TextfieldModel finder;
  final int mode;
  static const String _type = 'type';
  static const String _weight = 'weight';
  static const String _packing = 'packing';

  const ListviewProducts(
      {super.key,
      required this.finder,
      required this.listData,
      required this.mode});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              FinderProducts(
                currentFinder: finder,
                isLoading: false,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Clave',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Descripción',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Tipo',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Peso',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Empaque',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: IconButton(onPressed: onPressed, icon: icon)),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final productRow = listData[index];
                    return Container(
                      height: 30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45)),
                      child: OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                DrawerDetailsProduct(product: productRow),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              //1) Clave
                              flex: 1,
                              child: Center(
                                child: Text(
                                  productRow.code,
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 2) Descripción
                              flex: 1,
                              child: Center(
                                child: Text(
                                  productRow.description,
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 3) Tipo
                              flex: 1,
                              child: Center(
                                child: Text(
                                  productRow.properties[_type],
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 4) Peso
                              flex: 1,
                              child: Center(
                                child: Text(
                                  '${productRow.properties[_weight]} KG',
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 5) Empaque
                              flex: 1,
                              child: Center(
                                child: Text(
                                  productRow.properties[_packing],
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const ToolbarProducts(
          isLoading: false,
        ),
      ],
    );
  }
}
