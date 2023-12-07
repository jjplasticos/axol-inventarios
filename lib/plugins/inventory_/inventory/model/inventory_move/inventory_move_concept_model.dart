class InventoryMoveConceptModel {
  final int id;
  final int type;
  final String concept;

  const InventoryMoveConceptModel({
    required this.concept,
    required this.id,
    required this.type,
  });

  static InventoryMoveConceptModel empty() => const InventoryMoveConceptModel(
        concept: '',
        id: -1,
        type: -1,
      );
}
