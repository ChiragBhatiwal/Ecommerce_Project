import 'package:ecommerce_flutter/Models/OrderStatus_SellerAccountModel.dart';
import 'package:equatable/equatable.dart';

abstract class OrderStatusState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class InitialLoadingOrdersState extends OrderStatusState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingOrderStatusForManagingState extends OrderStatusState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedOrderStatusForManagingState extends OrderStatusState {
  List<OrderStatusModel> orderStatusModel;
  LoadedOrderStatusForManagingState({required this.orderStatusModel});
  @override
  // TODO: implement props
  List<Object?> get props => [orderStatusModel];
}

class ErrorLoadingOrderStatusForManagingState extends OrderStatusState {
  String? error;
  ErrorLoadingOrderStatusForManagingState({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
