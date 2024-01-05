import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/sale/customer/cubit/customer_add/customer_add_cubit.dart';
import '../../modules/sale/customer/cubit/customer_add/customer_add_form.dart';
import '../../modules/sale/customer/cubit/customer_delete/customer_delete_cubit.dart';
import '../../modules/sale/customer/cubit/customer_tab/customer_tab_cubit.dart';
import '../../modules/sale/customer/cubit/customer_tab/customer_tab_form.dart';
import '../../modules/sale/customer/model/customer_model.dart';
import '../../modules/sale/customer/view/customer_dialog_delete.dart';
import '../../modules/sale/customer/view/customer_drawer_add.dart';
import '../../modules/sale/sale_note/cubit/finder_notes_cubit.dart';
import '../../modules/sale/sale_note/cubit/sale_note_cubit/salenote_cubit.dart';
import '../../modules/sale/sale_note/view/views/sale_view.dart';

abstract class Providers extends StatelessWidget {
  const Providers({super.key});
}

class ProviderSaleView extends Providers {
  const ProviderSaleView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => SalenoteCubit()),
      BlocProvider(create: (_) => FinderNotesCubit()),
      BlocProvider(create: (_) => CustomerTabForm()),
      BlocProvider(create: (_) => CustomerTabCubit()),
    ], child: const SaleView());
  }
}

class ProviderCustomerAdd extends Providers {
  const ProviderCustomerAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => CustomerAddForm()),
      BlocProvider(create: (_) => CustomerAddCubit()),
    ], child: const CustomerDrawerAdd());
  }
}

class ProviderCustomerDelete extends Providers {
  final CustomerModel customer;
  const ProviderCustomerDelete({super.key, required this.customer});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(providers: [
        BlocProvider(create: (_) => CustomerDeleteCubit()),
      ], child: CustomerDialogDelete(customer: customer));
}
