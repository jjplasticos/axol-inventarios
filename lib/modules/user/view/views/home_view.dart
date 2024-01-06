import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/appbar/appbar_global.dart';
import '../../../../utilities/navigation_utilities.dart';
import '../../../../utilities/widgets/providers.dart';
import '../../../../utilities/theme.dart';
import '../../../inventory_/inventory/view/views/inventory_view.dart';
import '../../../sale/sale_note/cubit/finder_notes_cubit.dart';
import '../../../sale/sale_note/cubit/sale_note_cubit/salenote_cubit.dart';
import '../../../sale/sale_note/view/views/sale_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'Inicio';

    return Scaffold(
      backgroundColor: ColorPalette.darkBackground,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarGlobal(
          title: title,
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
          children: [
            NavigationRail(
              destinations: NavigationUtilities.navRail,
              selectedIndex: 0,
              backgroundColor: ColorPalette.darkBackground,
              indicatorColor: ColorPalette.primary,
              useIndicator: true,
              onDestinationSelected: (value) {
                if (value == 1) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InventoryView()));
                }
                if (value == 2) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SaleView()));
                }
              },
            ),
            const VerticalDivider(
                thickness: 1, width: 1, color: ColorPalette.darkItems),
          ],
        ),
      ),
    );
  }
}
