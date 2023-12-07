import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/inventory_move/inventory_move_concept_model.dart';
import '../../model/inventory_move/inventory_move_model.dart';
import '../../model/inventory_move/inventory_move_row_model.dart';

class MovesFormCubit extends Cubit<InventoryMoveModel>{
  MovesFormCubit() : super(InventoryMoveModel.empty());

  void setProducts(List<InventoryMoveRowModel> products) {
    InventoryMoveModel form = state;
    form.products = products;
    emit(form);
  }

  void selectConcept(String concept) {
    InventoryMoveModel form = state;
    form.concept = concept;
    emit(form);
  }

  void setConcepts(List<InventoryMoveConceptModel> concepts) {
    InventoryMoveModel form = state;
    form.concepts = concepts;
    emit(form);
  }

  void setDate(DateTime date) {
    InventoryMoveModel form = state;
    form.date = date;
    emit(form);
  }

  void setDocument(String document) {
    InventoryMoveModel form = state;
    form.document = document;
    emit(form);
  }

  void setInvTransfer(String setInvTransfer) {
    InventoryMoveModel form = state;
    form.invTransfer = setInvTransfer;
    emit(form);
  }
}