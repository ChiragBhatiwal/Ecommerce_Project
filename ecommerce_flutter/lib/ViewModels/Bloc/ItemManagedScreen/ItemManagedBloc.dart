import 'package:ecommerce_flutter/Models/ItemManagedScreenModel.dart';
import 'package:ecommerce_flutter/Services/Api/ItemManagedScreenApis.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/ItemManagedScreen/ItemManagedEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/ItemManagedScreen/ItemManagedState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemManagedBloc extends Bloc<ItemManagedEvents, ItemManagedStates> {
  ItemManagedBloc() : super(InitialItemManagedState()) {
    on<RequestItemsForItemMangedScreen>(
      (event, emit) async {
        emit(ItemManagedLoadingState());
        try {
          List<ItemManagedScreenModel> data =
              await ItemManagedScreenApis.fetchAllItems();

          emit(ItemManagedLoadedState(itemsList: data));
        } catch (e) {
          emit(ItemManagedLoadingFailed(error: e.toString()));
        }
      },
    );
  }
}
