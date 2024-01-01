import '../../../../models/textfield_form_model.dart';

class CustomerAddFormModel {
  TextfieldFormModel id;
  TextfieldFormModel name;
  TextfieldFormModel phoneNumber;
  TextfieldFormModel rfc;
  TextfieldFormModel postalCode;
  TextfieldFormModel intNumber;
  TextfieldFormModel outNumber;
  TextfieldFormModel street;
  TextfieldFormModel hood;
  TextfieldFormModel town;
  TextfieldFormModel country;

  CustomerAddFormModel({
    required this.country,
    required this.hood,
    required this.id,
    required this.intNumber,
    required this.name,
    required this.outNumber,
    required this.phoneNumber,
    required this.postalCode,
    required this.rfc,
    required this.street,
    required this.town,
  });

  CustomerAddFormModel.empty()
      : id = TextfieldFormModel.empty(),
        name = TextfieldFormModel.empty(),
        phoneNumber = TextfieldFormModel.empty(),
        rfc = TextfieldFormModel.empty(),
        postalCode = TextfieldFormModel.empty(),
        intNumber = TextfieldFormModel.empty(),
        outNumber = TextfieldFormModel.empty(),
        street = TextfieldFormModel.empty(),
        hood = TextfieldFormModel.empty(),
        town = TextfieldFormModel.empty(),
        country = TextfieldFormModel.empty();
}
