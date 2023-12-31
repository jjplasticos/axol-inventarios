import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../../global_widgets/navigation_utilities.dart';
import '../../../../../utilities/theme.dart';
import '../../../../inventory_/inventory/view/views/inventory_view.dart';
import '../../../../user/view/views/home_view.dart';
import '../../cubit/finder_notes_cubit.dart';
import '../../cubit/sale_note_cubit/salenote_cubit.dart';
import '../../cubit/sale_note_cubit/salenote_state.dart';
import '../widgets/finder_salenote.dart';
import '../widgets/toolbar_salenote.dart';
import 'salenote_tab.dart';

class SaleView extends StatelessWidget {
  const SaleView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SalenoteCubit()),
        BlocProvider(create: (_) => FinderNotesCubit()),
      ],
      child: DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: ColorPalette.darkBackground,
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: AppBarGlobal(
                title: 'Notas de venta',
                iconButton: null,
                iconActions: [],
              ),
            ),
            body: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigationRail(
                    destinations: NavigationUtilities.navRail,
                    selectedIndex: 2,
                    backgroundColor: ColorPalette.darkBackground,
                    indicatorColor: ColorPalette.primary,
                    useIndicator: true,
                    onDestinationSelected: (value) {
                      if (value == 0) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeView()));
                      }
                      if (value == 1) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InventoryView()));
                      }
                    },
                  ),
                  const VerticalDivider(
                      thickness: 1, width: 1, color: ColorPalette.darkItems),
                  Expanded(
                      child: Column(
                    children: [
                      const TabBar(
                        indicatorColor: ColorPalette.primary,
                        tabs: [
                          Tab(
                            text: 'Notas de venta',
                          ),
                          Tab(
                            text: 'Remisiones',
                          ),
                          Tab(
                            text: 'Clientes',
                          ),
                          Tab(
                            text: 'Vendedores',
                          ),
                        ],
                      ),
                      Expanded(
                          child: TabBarView(children: [
                        BlocBuilder<SalenoteCubit, SalenoteState>(
                          bloc: context.read<SalenoteCubit>()..loadList(),
                          builder: (context, state) {
                            if (state is LoadingState) {
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
                            } else if (state is LoadedState) {
                              return SaleNoteTab(
                                listData: state.salenoteList,
                              );
                            } else if (state is ErrorState) {
                              return Text(
                                state.error,
                                style: Typo.labelText1,
                              );
                            }
                            return Container();
                          },
                        ),
                        const Text('Remisiones', style: Typo.bodyLight),
                        const Text('Clientes', style: Typo.bodyLight),
                        const Text('Vendedores', style: Typo.bodyLight),
                      ])),
                    ],
                  )),
                ],
              ),
            ),
          )),
    );
  }
}
