class CustomerModel {
  final int id;
  final String name;
  final String? rfc;
  final String? street;
  final int? outNumber;
  final int? intNumber;
  final String? hood;
  final String? postalCode;
  final String? town;
  final String? country;
  final int? phoneNumber;

  static const String _id = 'id';
  static const String _name = 'name';
  static const String _rfc = 'rfc';
  static const String _street = 'street';
  static const String _outNumber = 'outNumber';
  static const String _intNumber = 'intNumber';
  static const String _hood = 'hood';
  static const String _postalCode = 'postalCode';
  static const String _town = 'town';
  static const String _country = 'country';
  static const String _phoneNumber = 'phoneNumber';

  String get tId => _id;
  String get tName => _name;
  String get tRfc => _rfc;
  String get tStreet => _street;
  String get tOutNumbre => _outNumber;
  String get tIntNumber => _intNumber;
  String get tHood => _hood;
  String get tPostalCode => _postalCode;
  String get tTown => _town;
  String get tCountry => _country;
  String get tPhoneNumber => _phoneNumber;

  const CustomerModel({
    required this.id,
    required this.name,
    this.country,
    this.hood,
    this.intNumber,
    this.outNumber,
    this.phoneNumber,
    this.postalCode,
    this.rfc,
    this.street,
    this.town,
  });

  CustomerModel.empty()
    : id = -1,
      name = '',
      country = '',
      hood = '',
      intNumber = -1,
      outNumber = -1,
      phoneNumber = -1,
      postalCode = '',
      rfc = '',
      street = '',
      town = '';

  CustomerModel.all({
    required this.id,
    required this.name,
    required this.country,
    required this.hood,
    required this.intNumber,
    required this.outNumber,
    required this.phoneNumber,
    required this.postalCode,
    required this.rfc,
    required this.street,
    required this.town,
  });

  CustomerModel.fill(Map<String, dynamic> map)
    : id = map[_id],
      name = map[_name],
      country = map[_country],
      hood = map[_hood],
      intNumber = map[_intNumber],
      outNumber = map[_outNumber],
      phoneNumber = map[_phoneNumber],
      postalCode = map[_postalCode],
      rfc = map[_rfc],
      street = map[_street],
      town = map[_town];
}
