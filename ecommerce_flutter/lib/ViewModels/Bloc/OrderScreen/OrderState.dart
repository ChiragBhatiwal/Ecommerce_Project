import 'package:ecommerce_flutter/Models/OrderScreenModel/OrderModel.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class InitialLoadingStateForOrderScreen extends OrderState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingStateForOrderScreen extends OrderState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadedStateForOrderScreen extends OrderState {
  final OrderModel orderModel;

  LoadedStateForOrderScreen({required this.orderModel});

  @override
  // TODO: implement props
  List<Object?> get props => [orderModel];
}

class ErrorLoadingStateForOrderScreen extends OrderState {
  String? error;

  ErrorLoadingStateForOrderScreen({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
