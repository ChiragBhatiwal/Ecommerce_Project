import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RequestOrderDetailsEvent extends OrderEvent {
  String? itemId;
  int? quantity;
  RequestOrderDetailsEvent({required this.quantity, required this.itemId});

  @override
  // TODO: implement props
  List<Object?> get props => [quantity, itemId];
}
