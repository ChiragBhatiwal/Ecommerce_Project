import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchProductDetails extends ProductDetailEvent {
  String? id;

  FetchProductDetails({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
