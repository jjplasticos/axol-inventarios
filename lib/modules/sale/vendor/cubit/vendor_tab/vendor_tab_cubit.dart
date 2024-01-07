import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/vendor_model.dart';
import '../../repository/vendor_repo.dart';
import 'vendor_tab_state.dart';

class VendorTabCubit extends Cubit<VendorTabState> {
  VendorTabCubit() : super(InitialVendorTabState());

  Future<void> load(String find) async {
    List<VendorModel> vendorListDB;
    try {
      emit(InitialVendorTabState());
      emit(LoadingVendorTabState());
      vendorListDB = await VendorRepo().fetchVendorIlike(find);
      emit(LoadedVendorTabState(vendorList: vendorListDB));
    } catch (e) {
      emit(InitialVendorTabState());
      emit(ErrorVendorTabState(error: e.toString()));
    }
  }
}