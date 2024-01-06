import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utilities/theme.dart';
import '../../cubit/sale_note_cubit/salenote_cubit.dart';
import '../../cubit/sale_note_cubit/salenote_state.dart';
import '../../model/sale_note_model.dart';
import '../widgets/finder_salenote.dart';
import '../widgets/toolbar_salenote.dart';

class SaleNoteTab extends StatelessWidget {
  const SaleNoteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalenoteCubit, SalenoteState>(
      bloc: context.read<SalenoteCubit>()..loadList(),
      builder: (context, state) {
        if (state is LoadingSaleNoteState) {
          return const Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  FinderSalenote(
                    isLoading: true,
                  ),
                  LinearProgressIndicator(),
                  Expanded(child: SizedBox())
                ],
              )),
              ToolbarSaleNote(
                isLoading: true,
              ),
            ],
          );
        } else if (state is LoadedSaleNoteState) {
          return saleNoteTab(context, state.salenoteList);
        } else if (state is ErrorSalenoteState) {
          return Text(
            state.error,
            style: Typo.labelText1,
          );
        }
        return Container();
      },
    );
  }

  Widget saleNoteTab(BuildContext context, List<SaleNoteModel> listData) {
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
