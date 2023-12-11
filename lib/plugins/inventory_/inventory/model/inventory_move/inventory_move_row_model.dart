class InventoryMoveRowModel {
  String code;
  String description;
  double quantity;
  double weightUnit;
  double weightTotal;
  String concept;
  bool stockExist;
  Map<String, String> states;

  static const String _tDescription = 'descriprion';

  String get tDescription => _tDescription;
  String get sInitial => 'stateInitial';
  String get sLoading => 'stateLoading';
  String get sLoaded => 'stateLoaded';
  String get sError => 'stateError';

  InventoryMoveRowModel({
    required this.code,
    required this.description,
    required this.quantity,
    required this.weightUnit,
    required this.weightTotal,
    required this.concept,
    required this.states,
    required this.stockExist,
  });

  InventoryMoveRowModel.empty()
      : code = '',
        description = '',
        quantity = 0,
        weightUnit = 0,
        weightTotal = 0,
        concept = '',
        stockExist = false,
        states = {_tDescription:''};
}

