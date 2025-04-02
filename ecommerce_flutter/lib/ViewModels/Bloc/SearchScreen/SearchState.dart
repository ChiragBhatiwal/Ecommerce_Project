import 'package:ecommerce_flutter/Models/SearchScreenModels.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialLoadingSearchProductsState extends SearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingSearchProductState extends SearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedSearchProductsState extends SearchState {
  List<SearchScreenModel> data;

  LoadedSearchProductsState({required this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class ErrorLoadingSearchProductsState extends SearchState {
  String error;

  ErrorLoadingSearchProductsState({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
