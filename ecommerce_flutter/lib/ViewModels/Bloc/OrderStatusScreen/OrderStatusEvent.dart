import 'package:ecommerce_flutter/Models/OrderStatus_SellerAccountModel.dart';

abstract class OrderStatusEvent {}

class RequestOrdersForStatusManage extends OrderStatusEvent {
  final List<String> keywords; // List of keywords
  RequestOrdersForStatusManage({required this.keywords});
}

class ChangeOrderStatusEvent extends OrderStatusEvent {
  final OrderStatusModel orderStatusModel;

  ChangeOrderStatusEvent({required this.orderStatusModel});
}
