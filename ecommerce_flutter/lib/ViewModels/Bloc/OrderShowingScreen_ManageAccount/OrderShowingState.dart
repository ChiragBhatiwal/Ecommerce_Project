import 'package:ecommerce_flutter/Models/OrderShowingScreen_ManageAccount.dart';
import 'package:equatable/equatable.dart';

class OrderShowingState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class initialState_ManageAccount extends OrderShowingState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingState_ManageAccount extends OrderShowingState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadedState_ManageAccount extends OrderShowingState {
  List<OrderShowingModel> orders;
  LoadedState_ManageAccount({required this.orders});
  @override
  // TODO: implement props
  List<Object?> get props => [orders];
}

class FailedState_ManageAccount extends OrderShowingState {
  String error;
  FailedState_ManageAccount({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
