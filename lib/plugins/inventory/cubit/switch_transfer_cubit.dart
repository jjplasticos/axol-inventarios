import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchTransferCubit extends Cubit<bool> {
  SwitchTransferCubit() : super(false);

  void change(bool newState) {
    emit(false);
    emit(newState);
  }
}
