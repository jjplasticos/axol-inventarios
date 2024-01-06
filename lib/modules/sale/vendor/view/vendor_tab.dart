import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/textfield_model.dart';
import '../../../../utilities/theme.dart';
import '../../../../utilities/widgets/finder_bar.dart';
import '../../../../utilities/widgets/progress_indicator.dart';
import '../cubit/vendor_tab_cubit.dart';
import '../cubit/vendor_tab_form.dart';
import '../model/vendor_model.dart';

class VendorTab extends StatelessWidget {
  final List<VendorModel> vendorList;
  final bool isLoading;

  const VendorTab({
    super.key,
    required this.vendorList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    TextfieldModel form = context.read<VendorTabForm>().state;
    TextfieldModel upForm;
    TextEditingController textController = TextEditingController();
    textController.value = TextEditingValue(
        text: form.text,
        selection: TextSelection.collapsed(offset: form.position));
    return Column(
      children: [
        Container(
          height: 50,
          color: ColorPalette.lightBackground,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FinderBar(
                  padding: const EdgeInsets.only(left: 12),
                  textController: textController,
                  txtForm: form,
                  enabled: !isLoading,
                  autoFocus: true,
                  isTxtExpand: true,
                  onSubmitted: (value) {
                    context.read<VendorTabCubit>().load(value);
                  },
                  onChanged: (value) {
                    upForm = TextfieldModel(
                        text: value,
                        position: textController.selection.base.offset);
                    context.read<VendorTabForm>().setForm(upForm);
                  },
                  onPressed: () {
                    if (isLoading == false) {
                      context
                          .read<VendorTabForm>()
                          .setForm(TextfieldModel.empty());
                      context.read<VendorTabCubit>().load('');
                    }
                  },
                ),
              ),
              const VerticalDivider(
                thickness: 1,
                width: 1,
                color: ColorPalette.lightItems,
                indent: 4,
                endIndent: 4,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SizedBox(), //Sustituir por ProviderVendorAdd
                  ).then((value) {
                    context.read<VendorTabCubit>().load(form.text);
                  });
                },
                icon: const Icon(
                  Icons.add_outlined,
                  color: ColorPalette.darkItems,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              color: ColorPalette.darkItems,
              border: Border(
                  bottom: BorderSide(
                width: 1,
                color: ColorPalette.darkItems,
              ))),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
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
                  flex: 5,
                  child: Text(
                    'Nombre',
                    style: Typo.subtitleLight,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: isLoading
              ? const Column(
                  children: [
                    LinearProgressIndicatorAxol(),
                    Expanded(child: SizedBox())
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: vendorList.length,
                  itemBuilder: (context, index) {
                    final customer = vendorList[index];
                    return Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 1,
                        color: ColorPalette.darkItems,
                      ))),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                        ),
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
                              flex: 5,
                              child: Text(
                                customer.name.toString(),
                                style: Typo.bodyLight,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => SizedBox() //Sustituir por VendorDrawerDetails
                                //CustomerDrawer(customer: customer),
                          ).then((value) {
                            //context.read<CustomerTabCubit>().load(form.text);
                          });
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}