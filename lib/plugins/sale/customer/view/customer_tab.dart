import 'package:axol_inventarios/plugins/sale/customer/cubit/customer_tab_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global_widgets/finder_bar.dart';
import '../../../../models/textfield_model.dart';
import '../../../../utilities/theme.dart';
import '../cubit/customer_tab_cubit.dart';
import '../model/customer_model.dart';

class CustomerTab extends StatelessWidget {
  final List<CustomerModel> customerList;
  final bool isLoading;

  const CustomerTab({
    super.key,
    required this.customerList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    TextfieldModel form = context.read<CustomerTabForm>().state;
    TextfieldModel upForm;
    TextEditingController textController = TextEditingController();
    textController.value = TextEditingValue(
        text: form.text,
        selection: TextSelection.collapsed(offset: form.position));
    return Column(
      children: [
        FinderBar(
          textController: textController,
          txtForm: form,
          enabled: !isLoading,
          autoFocus: true,
          isTxtExpand: true,
          onSubmitted: (value) {
            context.read<CustomerTabCubit>().load(value);
          },
          onChanged: (value) {
            upForm = TextfieldModel(
                text: value, position: textController.selection.base.offset);
            context.read<CustomerTabForm>().setForm(upForm);
          },
          onPressed: () {
            if (isLoading == false) {
              context.read<CustomerTabForm>().setForm(TextfieldModel.empty());
              context.read<CustomerTabCubit>().load('');
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'Id',
                    style: Typo.subtitleLight,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    'Nombre',
                    style: Typo.subtitleLight,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: isLoading
              ? const Center(
                  child: Text(
                    'Cargando...',
                    style: Typo.bodyLight,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: customerList.length,
                  itemBuilder: (context, index) {
                    final customer = customerList[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: OutlinedButton(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  customer.id.toString(),
                                  style: Typo.bodyLight,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  customer.name.toString(),
                                  style: Typo.bodyLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
