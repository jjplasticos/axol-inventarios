class RoutcutomerModel {
  final int id;
  final String name;
  final String location;
  final Map<String, dynamic> address;

  RoutcutomerModel({
    required this.id,
    required this.name,
    required this.location,
    required this.address,
  });

  static const String pId = 'id';
  static const String pName = 'name';
  static const String pLocation = 'location';
  static const String pAddress = 'address';
  static const String pHood = 'hood';
  static const String pTown = 'town';
  static const String pCountry = 'country';
}