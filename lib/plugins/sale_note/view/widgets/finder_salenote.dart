import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/textfield_model.dart';
import '../../../../utilities/theme.dart';
import '../../cubit/finder_notes_cubit.dart';
import '../../cubit/sale_note_cubit/salenote_cubit.dart';
import '../../model/salenote_filter_model.dart';

class FinderSalenote extends StatelessWidget {
  final bool isLoading;

  const FinderSalenote({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    TextfieldModel tfFinder = context.read<FinderNotesCubit>().state;
    String text = tfFinder.text;
    TextEditingController textController = TextEditingController();
    textController.value = TextEditingValue(
        text: tfFinder.text,
        selection: TextSelection.collapsed(offset: tfFinder.position));

    return Container(
      color: ColorPalette.lightBackground,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: TextFormField(
                controller: textController,
                autofocus: true,
                enabled: !isLoading,
                onFieldSubmitted: (value) {
                  context
                      .read<SalenoteCubit>()
                      .reloadList(value, SaleNoteFilterModel.empty());
                },
                onChanged: (value) {
                  //text = value;
                  TextfieldModel textfield = TextfieldModel(
                      text: value,
                      position: textController.selection.base.offset);
                  context.read<FinderNotesCubit>().setState(textfield);
                },
                decoration: InputDecoration(
                    hintText: 'Buscar',
                    hintStyle: Typo.hintText,
                    filled: true,
                    fillColor: ColorPalette.lightBackground,
                    border: InputBorder.none),
                style: Typo.textField1,
              ),
            ),
          ),
          IconButton(
            iconSize: 30,
            color: ColorPalette.darkText,
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              context
                  .read<SalenoteCubit>()
                  .reloadList(textController.text, SaleNoteFilterModel.empty());
            },
          ),
          IconButton(
            iconSize: 30,
            color: ColorPalette.darkText,
            icon: const Icon(
              Icons.cancel,
            ),
            onPressed: () {
              if (text != '') {
                context.read<SalenoteCubit>().loadList();
                context
                    .read<FinderNotesCubit>()
                    .setState(TextfieldModel.initial());
              }
            },
          ),
        ],
      ),
    );
  }
}
