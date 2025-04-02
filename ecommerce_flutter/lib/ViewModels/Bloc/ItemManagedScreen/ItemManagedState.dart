import 'package:ecommerce_flutter/Models/ItemManagedScreenModel.dart';
import 'package:equatable/equatable.dart';

abstract class ItemManagedStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class InitialItemManagedState extends ItemManagedStates {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ItemManagedLoadingState extends ItemManagedStates {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ItemManagedLoadedState extends ItemManagedStates {
  List<ItemManagedScreenModel> itemsList;

  ItemManagedLoadedState({required this.itemsList});

  @override
  // TODO: implement props
  List<Object?> get props => [itemsList];
}

class ItemManagedLoadingFailed extends ItemManagedStates {
  String error;

  ItemManagedLoadingFailed({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
