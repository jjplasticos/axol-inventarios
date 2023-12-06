class InventoryMoveRowModel {
  final String code;
  final String description;
  final String quantity;
  final double weightUnit;
  final double weightTotal;
  final String concept;
  final bool stockExist;

  const InventoryMoveRowModel(
      {required this.code,
      required this.description,
      required this.quantity,
      required this.weightUnit,
      required this.weightTotal,
      required this.concept,
      required this.stockExist});
}
