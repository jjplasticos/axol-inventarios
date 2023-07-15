class VendorModel {
  final int id;
  final String name;

  static const String propId = 'id';
  static const String propName = 'name';

  VendorModel({
    required this.id,
    required this.name,
  });

  static VendorModel empty() => VendorModel(id: -1, name: '');
}
