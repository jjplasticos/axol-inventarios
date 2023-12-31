import 'package:flutter/material.dart';

import '../../../../utilities/theme.dart';
import '../../model/sale_note_mdoel.dart';
import '../widgets/finder_salenote.dart';
import '../widgets/toolbar_salenote.dart';

class SaleNoteTab extends StatelessWidget {
  final List<SaleNoteModel> listData;

  const SaleNoteTab({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const FinderSalenote(
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
                      'Cliente',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Nombre de cliente',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Estado',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Fecha de elaboración',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Importe total',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Almacén',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Vendedor',
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
                    final saleNoteRow = listData[index];
                    return Container(
                      height: 30,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white12),
                        ),
                      ),
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
                              //1) Clave
                              flex: 1,
                              child: Center(
                                child: Text(
                                  saleNoteRow.id.toString(),
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 2) Cliente
                              flex: 1,
                              child: Center(
                                child: Text(
                                  saleNoteRow.customer.id.toString(),
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 3) Nombre de cliente
                              flex: 1,
                              child: Center(
                                child: Text(
                                  saleNoteRow.customer.name,
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 4) Estado
                              flex: 1,
                              child: Center(
                                child: Text(
                                  saleNoteRow.status.toString(),
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 5) Fecha de elaboración
                              flex: 1,
                              child: Center(
                                child: Text(
                                  '${saleNoteRow.date.day}/${saleNoteRow.date.month}/${saleNoteRow.date.year}',
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 6) Importe total
                              flex: 1,
                              child: Center(
                                child: Text(
                                  '\$${saleNoteRow.total}',
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 7) Almacen
                              flex: 1,
                              child: Center(
                                child: Text(
                                  saleNoteRow.warehouse.id.toString(),
                                  style: Typo.labelText1,
                                ),
                              ),
                            ),
                            Expanded(
                              // 7) Vendedor
                              flex: 1,
                              child: Center(
                                child: Text(
                                  saleNoteRow.vendor.name,
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
        const ToolbarSaleNote(
          isLoading: false,
        ),
      ],
    );
  }
}
