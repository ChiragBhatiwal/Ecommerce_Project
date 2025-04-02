import 'package:ecommerce_flutter/Services/Api/OrderShowing_ManageAccountApi.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderShowingScreen_ManageAccount/OrderShowingEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderShowingScreen_ManageAccount/OrderShowingState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderShowingBloc extends Bloc<OrderShowingEvent, OrderShowingState> {
  OrderShowingBloc() : super(initialState_ManageAccount()) {
    on<RequestBuyAgainOrdersEvent>(
      (event, emit) async {
        emit(LoadingState_ManageAccount());
        try {
          final orders = await OrderShowingApi().fetchBuyAgainOrders();
          emit(LoadedState_ManageAccount(orders: orders));
        } catch (e) {
          emit(FailedState_ManageAccount(error: e.toString()));
        }
      },
    );
    on<RequestCurrentOrdersEvent>(
      (event, emit) async {
        emit(LoadingState_ManageAccount());
        try {
          final orders = await OrderShowingApi().fetchCurrentOrders();
          emit(LoadedState_ManageAccount(orders: orders));
        } catch (e) {
          emit(FailedState_ManageAccount(error: e.toString()));
        }
      },
    );
  }
}
