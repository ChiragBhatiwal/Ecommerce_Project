import 'package:ecommerce_flutter/Models/ProductDetailScreenModel.dart';
import 'package:equatable/equatable.dart';

abstract class ProductDetailState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class InitialProductLoadingStateProductDetailsScreen
    extends ProductDetailState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingProductStateProductDetailsScreen extends ProductDetailState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedProductStateProductDetailScreen extends ProductDetailState {
  ProductDetailScreenModel data;

  LoadedProductStateProductDetailScreen({required this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class ErrorLoadingProductDetailScreen extends ProductDetailState {
  String error;

  ErrorLoadingProductDetailScreen({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
