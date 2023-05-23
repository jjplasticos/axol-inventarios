class MovementModel {
  final String id;
  final String time;
  final String code;
  final String description;
  final String document;
  final String warehouse;
  final int concept;
  final int conceptType;
  final double quantity;

  MovementModel({
    required this.id,
    required this.code,
    required this.concept,
    required this.conceptType,
    required this.description,
    required this.document,
    required this.quantity,
    required this.time,
    required this.warehouse,
  });
}
