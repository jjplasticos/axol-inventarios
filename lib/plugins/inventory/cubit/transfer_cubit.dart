import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/warehouses_repo.dart';

class TransferCubit extends Cubit<List<String>> {
  TransferCubit() : super([]);

  Future<void> change(bool isTransfer) async {
    List<String> list;

    if (isTransfer == false) {
      emit([]);
    } else {
      list = await WarehousesRepo().fetchNames();
      emit([]);
      emit(list);
    }
  }
}
