import 'package:ecommerce_flutter/ViewModels/Bloc/OrderStatusScreen/OrderStatusBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderStatusScreen/OrderStatusEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderStatusScreen/OrderStatusState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../Models/OrderStatus_SellerAccountModel.dart';
import '../../../../Services/Socket/Sockets.dart';

class Acceptedorders extends StatefulWidget {
  const Acceptedorders({super.key});

  @override
  State<Acceptedorders> createState() => _AcceptedordersState();
}

class _AcceptedordersState extends State<Acceptedorders> {
  String formatPrice(int price) {
    final numberFormat = NumberFormat("#,##,##0", "en_IN");
    return numberFormat.format(price);
  }

  List<String> status = ['Confirmed', 'Packed', 'Shipped'];

  @override
  void initState() {
    super.initState();
    final orderStatusBloc = context.read<OrderStatusBloc>();
    if (orderStatusBloc.state is! LoadingOrderStatusForManagingState) {
      orderStatusBloc.add(RequestOrdersForStatusManage(keywords: status));
    }
  }

  List<String> data = ["Packed", "Shipped", "Delivered", "Cancelled"];

  String? _updateValue = "Packed"; // Set a default value here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderStatusBloc, OrderStatusState>(
        builder: (context, state) {
          if (state is LoadingOrderStatusForManagingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedOrderStatusForManagingState) {
            if (state.orderStatusModel.isEmpty) {
              return const Center(
                child: Text(
                  "Order List is Empty",
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              List<OrderStatusModel> orders = state.orderStatusModel;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  OrderStatusModel? products = orders[index];
                  //Parent Container
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(8.0)),
                      height: 250,
                      width: double.infinity,
                      //Box - Parent Box For Widgets
                      child: Column(
                        children: [
                          //Product -> Name And Price + Quantity
                          Flexible(
                            flex: 3,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, left: 8.0),
                                        child: Text(
                                          products?.productName?.toString() ??
                                              'Unknown Product',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 4.0),
                                        child: Text(
                                          "₹${formatPrice(products?.totalBill?.toInt() ?? 0)}",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: Text(
                                          "x${products?.quantity ?? 0}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Another Box --> For Rest Of Info(Ex:- User and Status)
                          Flexible(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                        color: Colors.black26, width: 1)),
                                //Box Divided into 2 Parts
                                child: Column(
                                  children: [
                                    //User Address and Status
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 75,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            top: 5.0),
                                                    child: Text(
                                                      products?.username
                                                              ?.toUpperCase() ??
                                                          'Unknown User',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            top: 4.0),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        text:
                                                            "${products?.userAddress?.toUpperCase() ?? 'Unknown Address'}, ",
                                                        children: [
                                                          TextSpan(
                                                            text: products
                                                                    ?.userCity
                                                                    ?.toUpperCase() ??
                                                                'Unknown City',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                products?.status ?? 'Unknown',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //Payment Type and Changing Status of Order
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                text: "Payment Via - ",
                                                children: [
                                                  TextSpan(
                                                    style: const TextStyle(
                                                        color: Colors.green),
                                                    text:
                                                        "${products?.paymentType ?? 'Unknown'}",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, bottom: 5.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1)),
                                              child: DropdownButton<String>(
                                                padding: EdgeInsets.all(4.0),
                                                underline: SizedBox(),
                                                hint:
                                                    const Text("Select Value"),
                                                value: _updateValue,
                                                items: data.map((String data) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: data,
                                                    child: Text(data),
                                                  );
                                                }).toList(),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _updateValue = value!;
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        backgroundColor:
                                                            Colors.cyan,
                                                        content: Text(
                                                          "You're Changing Status to :- ${_updateValue}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        action: SnackBarAction(
                                                          textColor:
                                                              Colors.amber,
                                                          label: "Ok",
                                                          onPressed: () {
                                                            SocketService()
                                                                .emit(
                                                              "update-order-status",
                                                              {
                                                                "status":
                                                                    _updateValue!,
                                                                "orderId":
                                                                    products
                                                                        .orderId
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else if (state is ErrorLoadingOrderStatusForManagingState) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
