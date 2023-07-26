import 'package:flutter/material.dart';

import '../../../../../models/textfield_model.dart';
import '../../../../../settings/theme.dart';
import '../../model/routcustomer_model.dart';
import 'toolbar_rc.dart';

class ListviewRc extends StatelessWidget {
  final List<RoutcutomerModel> listData;
  final TextfieldModel finder;

  const ListviewRc(
      {super.key,
      required this.finder,
      required this.listData});

  @override
  Widget build(BuildContext context) {
    Icon icon =
        const Icon(Icons.error_outline, color: ColorPalette.primaryText);
    Function()? action;

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              /*FinderProducts(
                currentFinder: finder,
                isLoading: false,
                mode: mode,
              ),*/
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Id',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Nombre',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Ubicación',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Direción',
                      style: Typo.bodyText5,
                    )),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final rcRow = listData[index];

                    return Container(
                      height: 30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45)),
                      child: OutlinedButton(
                        onPressed: () {
                          /*showDialog(
                            context: context,
                            builder: (context) =>
                                DrawerDetailsProduct(product: productRow),
                          );*/
                        },
                        child: Row(
                          children: [
                            Expanded(
                              //1) ID
                              flex: 1,
                              child: Center(
                                child: Text(
                                  rcRow.id.toString(),
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 2) Nombre
                              flex: 1,
                              child: Center(
                                child: Text(
                                  rcRow.name,
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 3) Ubicación
                              flex: 1,
                              child: Center(
                                child: Text(
                                  rcRow.location,
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 4) Dirección
                              flex: 1,
                              child: Center(
                                child: Text(
                                  '${RoutcutomerModel.pAddress}, ${RoutcutomerModel.pHood}, ${RoutcutomerModel.pTown}, ${RoutcutomerModel.pCountry}',
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
        ToolbarRc(
          isLoading: false,
        ),
      ],
    );
  }
}