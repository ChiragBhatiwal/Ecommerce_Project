import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RequestCartProductsEvent extends CartEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
