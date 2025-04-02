import 'package:ecommerce_flutter/Models/OrderScreenModel/OrderModel.dart';
import 'package:ecommerce_flutter/Services/Api/OrderScreenApis.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderScreen/OrderEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderScreen/OrderState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(InitialLoadingStateForOrderScreen()) {
    on<RequestOrderDetailsEvent>(
      (event, emit) async {
        emit(LoadingStateForOrderScreen());

        try {
          OrderModel? orderModel = await OrderScreenApis()
              .getDetailsForOrder(event.quantity, event.itemId);
          emit(LoadedStateForOrderScreen(orderModel: orderModel!));
        } catch (e) {
          emit(ErrorLoadingStateForOrderScreen(error: e.toString()));
        }
      },
    );
  }
}
