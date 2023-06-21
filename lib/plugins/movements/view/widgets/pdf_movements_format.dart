import 'package:flutter/services.dart'; //
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../model/movement_model.dart';

class PdfMovementsFormats {
  Future<Uint8List> pdfMovements(List<MovementModel> movements) async {
    final pdf = pw.Document();
    //final ByteData bytes = await rootBundle.load('assets/phone.png');
    //final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(text: "Historial de movimientos", level: 1),
                pw.Divider(borderStyle: pw.BorderStyle.dashed),
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        flex: 1,
                        child: pw.Center(
                          child: pw.Text('Almacén'),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Center(
                          child: pw.Text('Documento'),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Center(
                          child: pw.Text('Clave'),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Center(
                          child: pw.Text('Descripción'),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Center(
                          child: pw.Text('Concepto'),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Center(
                          child: pw.Text('Fecha'),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Center(
                          child: pw.Text('Cantidad'),
                        ),
                      ),
                    ]),
                pw.Divider(borderStyle: pw.BorderStyle.dashed),
                pw.ListView.builder(
                  itemCount: movements.length,
                  itemBuilder: (context, index) {
                    final move = movements[index];
                    return pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            flex: 1,
                            child: pw.Center(
                              child: pw.Text(move.warehouse),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Center(
                              child: pw.Text(move.document),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Center(
                              child: pw.Text(move.code),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Center(
                              child: pw.Text(move.description),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Center(
                              child: pw.Text(move.concept.toString()),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Center(
                              child: pw.Text(
                                  '${move.time.day}/${move.time.month}/${move.time.year}'),
                            ),
                          ),
                          pw.Expanded(
                            flex: 1,
                            child: pw.Center(
                              child: pw.Text(move.quantity.toString()),
                            ),
                          ),
                        ]);
                  },
                ),
                //pw.Paragraph(text: 'Hola mundo!!'),
              ]);
        }));
    return pdf.save();
  }
}
