class InventoryMoveRowModel {
  final String code;
  final double quantity;
  final double weightUnit;
  final double weightTotal;

  const InventoryMoveRowModel(
      {required this.code,
      required this.quantity,
      required this.weightUnit,
      required this.weightTotal});
}
