import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/toolbar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../../../settings/theme.dart';
import '../../cubit/movement_filters/movement_filters_cubit.dart';
import '../../model/movement_model.dart';
import '../controllers/drawer_movement_controller.dart';
import 'drawer_details_movements.dart';

class ListviewMovements extends StatelessWidget {
  final List<MovementModel> movementsList;

  const ListviewMovements({super.key, required this.movementsList});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
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
                      'Documento',
                      style: Typo.bodyText5,
                    )),
                  ),
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
                      'Concepto',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Fecha',
                      style: Typo.bodyText5,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Cantidad',
                      style: Typo.bodyText5,
                    )),
                  ),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: movementsList.length,
                itemBuilder: (context, index) {
                  final movement = movementsList[index];
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
                              DrawerDetailsMovements(movement: movement),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            //1) Warehouse
                            flex: 1,
                            child: Center(
                              child: Text(
                                movement.warehouse,
                                style: Typo.labelText1,
                              ),
                            ),
                          ),
                          Expanded(
                            // 2) Document
                            flex: 1,
                            child: Center(
                              child: Text(
                                movement.document,
                                style: Typo.labelText1,
                              ),
                            ),
                          ),
                          Expanded(
                            // 3) Code
                            flex: 1,
                            child: Center(
                              child: Text(
                                movement.code,
                                style: Typo.labelText1,
                              ),
                            ),
                          ),
                          Expanded(
                            // 4) Description
                            flex: 1,
                            child: Center(
                              child: Text(
                                movement.description,
                                style: Typo.labelText1,
                              ),
                            ),
                          ),
                          Expanded(
                            // 5) Concept
                            flex: 1,
                            child: Center(
                              child: Text(
                                movement.concept.toString(),
                                style: Typo.labelText1,
                              ),
                            ),
                          ),
                          Expanded(
                            // 6) Date
                            flex: 1,
                            child: Center(
                              child: Text(
                                movement.time,
                                style: Typo.labelText1,
                              ),
                            ),
                          ),
                          Expanded(
                            // 7) Quantity
                            flex: 1,
                            child: Center(
                              child: Text(
                                movement.quantity.toString(),
                                style: Typo.labelText1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ))
            ],
          ),
        ),
        Toolbar(
          listData: [
            ElementsBarModel(
              text: null,
              icon: const Icon(Icons.add),
              action: () {},
            ),
            ElementsBarModel(
              text: null,
              icon: const Icon(Icons.filter_alt),
              action: () {
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider(
                      create: (_) => MovementFiltersCubit(),
                      child: const DrawerMovementsController()),
                );
              },
            ),
            ElementsBarModel(
              text: null,
              icon: const Icon(Icons.restart_alt),
              action: () {},
            )
          ],
        )
      ],
    );
  }
}
