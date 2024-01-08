import '../../../../models/textfield_form_model.dart';
import 'sale_note_model.dart';

class SaleNoteRowFormModel {
  TextfieldFormModel quantity;
  TextfieldFormModel productCode;
  TextfieldFormModel unitPrice;
  String note;

  static const String _lblQuantity = 'Cantidad:';
  static const String _lblCode = 'Producto:';
  static const String _lblPrice = 'Precion unitario:';


  SaleNoteRowFormModel({
    required this.quantity,
    required this.productCode,
    required this.unitPrice,
    required this.note,
  });

  SaleNoteRowFormModel.empty() :
        quantity =  TextfieldFormModel.empty(),
        productCode = TextfieldFormModel.empty(),
        unitPrice = TextfieldFormModel.empty(),
        note = '';
}