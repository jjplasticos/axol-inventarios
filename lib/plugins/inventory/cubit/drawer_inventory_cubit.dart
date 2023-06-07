import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerInventoryCubit extends Cubit<bool> {
  DrawerInventoryCubit() : super(false);

  void openDrawer() {
    emit(true);
  }

  void closeDrawer() {
    emit(false);
  }
}
