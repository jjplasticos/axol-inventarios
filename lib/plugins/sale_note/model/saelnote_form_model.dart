import '../../../models/textfield_form_model.dart';

class SalenoteFormModel {
  TextfieldFormModel customer;
  TextfieldFormModel vendor;
  TextfieldFormModel warehouse;

  SalenoteFormModel({
    required this.customer,
    required this.vendor,
    required this.warehouse,
  });

  static SalenoteFormModel initial() => SalenoteFormModel(
        customer: TextfieldFormModel.initial(),
        vendor: TextfieldFormModel.initial(),
        warehouse: TextfieldFormModel.initial(),
      );
}
