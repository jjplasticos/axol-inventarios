class RoutcustomerModel {
  final int id;
  final String name;
  final String location;
  final Map<String, dynamic> address;
  final Map<String, dynamic> validation;

  const RoutcustomerModel(
      {required this.id,
      required this.name,
      required this.location,
      required this.address,
      required this.validation});

  static const String pId = 'id';
  static const String pName = 'name';
  static const String pLocation = 'location';
  //-----Address-----
  static const String pAddress = 'address';
  static const String pHood = 'hood';
  static const String pTown = 'town';
  static const String pCountry = 'country';
  //-----Validation-----
  static const String pStatus = 'status';
  static const String pAdminUser = 'user';
}
