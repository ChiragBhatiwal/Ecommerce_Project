import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchSearchProductsEvent extends SearchEvent {
  String value;
  FetchSearchProductsEvent({required this.value});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ResetSearchStateEvent extends SearchEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
