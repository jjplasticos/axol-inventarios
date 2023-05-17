class InventoryMoveRowModel {
  final String code;
  final String description;
  final double quantity;
  final double weightUnit;
  final double weightTotal;
  final String concept;

  const InventoryMoveRowModel(
      {required this.code,
      required this.description,
      required this.quantity,
      required this.weightUnit,
      required this.weightTotal,
      required this.concept});
}
