import '../../../../models/textfield_form_model.dart';

class RcFormModel {
  TextfieldFormModel id;
  TextfieldFormModel name;
  TextfieldFormModel location;
  TextfieldFormModel address;
  TextfieldFormModel hood;
  TextfieldFormModel town;
  TextfieldFormModel country;
  bool status;
  String user;

  RcFormModel({
    required this.id,
    required this.name,
    required this.location,
    required this.address,
    required this.hood,
    required this.town,
    required this.country,
    required this.status,
    required this.user
  });

  static RcFormModel empty() => RcFormModel(
        id: TextfieldFormModel.initial(),
        name: TextfieldFormModel.initial(),
        location: TextfieldFormModel.initial(),
        address: TextfieldFormModel.initial(),
        hood: TextfieldFormModel.initial(),
        town: TextfieldFormModel.initial(),
        country: TextfieldFormModel.initial(),
        status: true,
        user: '',
      );
}