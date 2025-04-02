import 'package:ecommerce_flutter/Models/OrderStatus_SellerAccountModel.dart';
import 'package:ecommerce_flutter/Services/Api/OrderStatusApis.dart';
import 'package:ecommerce_flutter/Services/Socket/Sockets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'OrderStatusEvent.dart';
import 'OrderStatusState.dart';

class OrderStatusBloc extends Bloc<OrderStatusEvent, OrderStatusState> {
  List<OrderStatusModel> orderList = [];
  List<String> keywords = [];

  OrderStatusBloc() : super(InitialLoadingOrdersState()) {
    // Event handler to request orders for a specific keyword
    on<RequestOrdersForStatusManage>(
      (event, emit) async {
        emit(LoadingOrderStatusForManagingState());
        try {
          // Update the keywords stored in the Bloc
          keywords = event.keywords;

          // Fetch orders based on the keywords
          orderList = await ManageOrderStatusApis().getOrders(keywords);
          emit(LoadedOrderStatusForManagingState(orderStatusModel: orderList));
        } catch (e) {
          emit(ErrorLoadingOrderStatusForManagingState(error: e.toString()));
        }
      },
    );

    // Event handler to change the order status and update the list
    on<ChangeOrderStatusEvent>(
      (event, emit) {
        emit(LoadingOrderStatusForManagingState());

        // Check if the updated status matches the current keyword list
        if (keywords.contains(event.orderStatusModel.status)) {
          // Update the order if the status matches
          orderList = orderList.map((order) {
            if (order.orderId == event.orderStatusModel.orderId) {
              return event
                  .orderStatusModel; // Replace the old order with the updated one
            }
            return order;
          }).toList();
        } else {
          // Remove the order if its status no longer matches the current keyword
          orderList.removeWhere(
              (order) => order.orderId == event.orderStatusModel.orderId);
        }

        // Emit the updated order list
        emit(LoadedOrderStatusForManagingState(
            orderStatusModel: List.from(orderList)));
      },
    );

    // Listen to socket events for real-time updates
    SocketService().on("order-updated", (dynamic data) {
      print('Socket data received: $data');
      List<dynamic> orderList = data;

      // Convert the first object of the list to your OrderStatusModel
      OrderStatusModel orderStatusModel =
          OrderStatusModel.fromJson(orderList[0]);

      // Add the event to the Bloc to update the order status
      add(ChangeOrderStatusEvent(orderStatusModel: orderStatusModel));
    });
  }
}
