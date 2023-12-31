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

  static VendorModel fillMap(Map<String, dynamic> map) {
    VendorModel vendorModel;
    if (map.keys.contains(propId) && map.keys.contains(propName)) {
      vendorModel = VendorModel(id: map[propId], name: map[propName]);
    } else {
      vendorModel = VendorModel.empty();
    }
    return vendorModel;
  }
}
