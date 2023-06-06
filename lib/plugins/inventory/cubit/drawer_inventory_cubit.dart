import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerInventoryCubit extends Cubit<int> {
  DrawerInventoryCubit() : super(-1);

  void openDrawer() {
    emit(1);
  }

  void closeDrawer() {
    emit(0);
  }
}
