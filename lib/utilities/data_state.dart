class DataState {
  String state;
  String? message;

  static const initial = 'stateInitial';
  static const error = 'stateError';
  static const loading = 'stateLoading';
  static const loaded = 'stateLoaded';

  DataState({required this.state, this.message});
}