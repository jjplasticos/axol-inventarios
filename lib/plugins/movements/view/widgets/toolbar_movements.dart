import 'dart:typed_data';

import 'package:axol_inventarios/models/textfield_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../global_widgets/toolbar.dart';
import '../../../../models/elemnets_bar_model.dart';
import '../../cubit/movement_filters/movement_filters_cubit.dart';
import '../../cubit/movements_view/movements_cubit.dart';
import '../../model/movement_filter_model.dart';
import '../controllers/drawer_movement_controller.dart';

class ToolbarMovements extends StatelessWidget {
  final bool isLoading;
  final MovementFilterModel currentFilter;
  const ToolbarMovements(
      {super.key, required this.isLoading, required this.currentFilter});

  @override
  Widget build(BuildContext context) {
    return Toolbar(
      listData: [
        /*ElementsBarModel(
          text: null,
          icon: const Icon(Icons.add),
          action: () {},
        ),*/
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.filter_alt),
          action: () {
            if (isLoading == false) {
              showDialog(
                context: context,
                builder: (context) => BlocProvider(
                    create: (_) => MovementFiltersCubit(),
                    child: DrawerMovementsController(
                      currentFilter: currentFilter,
                    )),
              ).then((value) {
                if (value != null) {
                  context.read<MovementsCuibit>().finderList(
                      value, const TextfieldModel(text: '', position: 0));
                }
                //print(value);
              });
            }
          },
        ),
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.restart_alt),
          action: () {
            context.read<MovementsCuibit>().loadList();
          },
        ),
        ElementsBarModel(
          text: null,
          icon: const Icon(Icons.print),
          action: () async {
            /*final Uint8List fontData = File('open-sans.ttf').readAsBytesSync();
            final ttf = pw.Font.ttf(fontData.buffer.asByteData());*/
            /*final font = await rootBundle.load("assets/open-sans.ttf");
            final ttf = pw.Font.ttf(font);*/
            final font = await PdfGoogleFonts.nunitoExtraLight();

            final pdf = pw.Document();
            pdf.addPage(pw.Page(
              pageFormat: PdfPageFormat.a4,
              build: (pw.Context context) {
                return pw.Center(
                  child: pw.Text('Hola mundo!', style: pw.TextStyle(font: font, fontSize: 40),)
                );
              }
            ));
            final output = await getTemporaryDirectory();
            final outputFile = File('${output.path}/holaMundo.pdf');
            await outputFile.writeAsBytes(await pdf.save());
          },
        )
      ],
    );
  }
}
