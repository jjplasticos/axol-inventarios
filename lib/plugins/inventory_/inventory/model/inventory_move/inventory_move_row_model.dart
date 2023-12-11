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
  static const String _tErrorMessage = 'errorMessage';
  static const String _sInitial = 'stateInitial';
  static const String _sLoading = 'stateLoading';
  static const String _sLoaded = 'stateLoaded';
  static const String _sError = 'stateError';
  static const String _erNotProduct = 'errorNotProduct';

  String get tDescription => _tDescription;
  String get tErrorMessage => _tErrorMessage;
  String get sInitial => _sInitial;
  String get sLoading => _sLoading;
  String get sLoaded => _sLoaded;
  String get sError => _sError;
  String get erNotProduct => _erNotProduct;

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
        states = {_tDescription: _sInitial, _tErrorMessage: _erNotProduct};
}
