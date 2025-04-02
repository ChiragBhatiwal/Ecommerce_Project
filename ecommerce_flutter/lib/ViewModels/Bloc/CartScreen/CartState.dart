import 'package:ecommerce_flutter/Models/CartScreenModels.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class InitialCartProductState extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductLoadingCartScreenState extends InitialCartProductState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ProductLoadedCartScreenState extends CartState {
  List<CartScreenModel> productList = [];

  ProductLoadedCartScreenState({required this.productList});

  @override
  // TODO: implement props
  List<Object?> get props => [productList];
}

class ErrorLoadingProductCartScreenState extends CartState {
  String error;

  ErrorLoadingProductCartScreenState({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
