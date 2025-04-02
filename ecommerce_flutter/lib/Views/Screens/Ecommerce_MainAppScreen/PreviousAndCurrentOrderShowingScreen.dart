import 'package:ecommerce_flutter/Models/OrderShowingScreen_ManageAccount.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderShowingScreen_ManageAccount/OrderShowingBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderShowingScreen_ManageAccount/OrderShowingEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderShowingScreen_ManageAccount/OrderShowingState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PreviousAndCurrentOrderShowingScreen extends StatelessWidget {
  int showingScreenId;
  PreviousAndCurrentOrderShowingScreen(
      {super.key, required this.showingScreenId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderShowingBloc()
        ..add(showingScreenId == 0
            ? RequestCurrentOrdersEvent()
            : RequestBuyAgainOrdersEvent()),
      child: OrderScreenContent(showingScreenId: showingScreenId),
    );
  }
}

class OrderScreenContent extends StatelessWidget {
  final int showingScreenId;
  OrderScreenContent({required this.showingScreenId});

  @override
  Widget build(BuildContext context) {
    var _media = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: showingScreenId == 0
              ? const Text(
                  "Current-Orders",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              : const Text(
                  "Buy-Again",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
          centerTitle: true,
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return BlocBuilder<OrderShowingBloc, OrderShowingState>(
                builder: (context, state) {
                  if (state is LoadingState_ManageAccount) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedState_ManageAccount) {
                    if (state.orders.isEmpty) {
                      return const Center(
                        child: Text(
                          "Let's Start Shopping!",
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    } else {
                      return portraitOrdersShowingScreen(
                          context, _media.size, state);
                    }
                  } else if (state is FailedState_ManageAccount) {
                    return Center(
                      child: Text(state.error.toString()),
                    );
                  } else {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }
                },
              );
            } else {
              return landscapeOrdersShowingScreen(context, _media.size);
            }
          },
        ),
      ),
    );
  }

  String formatPrice(int price) {
    final numberFormat = NumberFormat("#,##,##0", "en_IN");
    return numberFormat.format(price);
  }

  Widget portraitOrdersShowingScreen(
      BuildContext context, Size size, LoadedState_ManageAccount state) {
    if (showingScreenId == 0) {
      return ListView.builder(
        itemCount: state.orders!.length,
        itemBuilder: (context, index) {
          OrderShowingModel orderShowingModel = state.orders![index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            //Displaying all the info about Buy-again Products
            child: Container(
              width: size.width * 1,
              height: size.height * 0.28,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                children: [
                  //Showing Image Of Product
                  SizedBox(
                    height: size.height * 1,
                    width: size.width * 0.4,
                    child: Image.network(
                      orderShowingModel.productImage[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  //All Details Of Product
                  Container(
                    height: size.height * 1,
                    width: size.width * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Product Name Displaying
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            orderShowingModel.productName.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        //Total Bill at The time of Purchasing
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Total Bill :- ₹${formatPrice(orderShowingModel.totalBill)}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                        //Quantity Showing
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Quantity  x${orderShowingModel.quantity}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Product Original Price Showing
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Original Price :- ₹${formatPrice(orderShowingModel.productPrice)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Purchased Date Showing
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Purchased on :- ${orderShowingModel.createdAt.day}-${orderShowingModel.createdAt.month}-${orderShowingModel.createdAt.year},${orderShowingModel.createdAt.hour}:${orderShowingModel.createdAt.minute}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      //Checking if Orders are null or not
      return ListView.builder(
        itemCount: state.orders!.length,
        itemBuilder: (context, index) {
          OrderShowingModel orderShowingModel = state.orders![index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            //Displaying all the info about Buy-again Products
            child: Container(
              width: size.width * 1,
              height: size.height * 0.28,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                children: [
                  //Showing Image Of Product
                  SizedBox(
                    height: size.height * 1,
                    width: size.width * 0.4,
                    child: Image.network(
                      orderShowingModel.productImage[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  //All Details Of Product
                  Container(
                    height: size.height * 1,
                    width: size.width * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Product Name Displaying
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            orderShowingModel.productName.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        //Total Bill at The time of Purchasing
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Total Bill :- ₹${formatPrice(orderShowingModel.totalBill)}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                        //Quantity Showing
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Quantity  x${orderShowingModel.quantity}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Product Original Price Showing
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Original Price :- ₹${formatPrice(orderShowingModel.productPrice)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Purchased Date Showing
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Purchased on :- ${orderShowingModel.createdAt.day}-${orderShowingModel.createdAt.month}-${orderShowingModel.createdAt.year},${orderShowingModel.createdAt.hour}:${orderShowingModel.createdAt.minute}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Widget landscapeOrdersShowingScreen(BuildContext context, Size size) {
    return Center(
      child: Text("dbiuwebf"),
    );
  }
}
