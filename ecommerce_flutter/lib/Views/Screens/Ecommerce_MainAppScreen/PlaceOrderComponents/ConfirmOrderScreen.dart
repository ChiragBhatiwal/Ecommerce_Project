import 'package:ecommerce_flutter/Services/Api/AddressScreenApis.dart';
import 'package:ecommerce_flutter/Services/Api/OrderScreenApis.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderScreen/OrderBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderScreen/OrderEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderScreen/OrderState.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/AddressSubmitionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmOrderScreen extends StatelessWidget {
  final String? paymentValue, itemId;
  const ConfirmOrderScreen(
      {super.key, required this.paymentValue, required this.itemId});

  @override
  Widget build(BuildContext context) {
    context
        .read<OrderBloc>()
        .add(RequestOrderDetailsEvent(quantity: 1, itemId: itemId!));

    Future<int?> hasAddress = AddressScreenApis().findAddress();
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              title: const Text(
                "Confirm Order",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: FutureBuilder<int?>(
              future: hasAddress,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  if (snapshot.data == 1) {
                    return BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        if (state is LoadingStateForOrderScreen) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is LoadedStateForOrderScreen) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 5.0, left: 14.0, bottom: 5.0),
                                    child: Text(
                                      "Shipping Address",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.tealAccent,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                  ),
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 15.0, left: 14.0, bottom: 5.0),
                                    child: Text(
                                      "Product Detail",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.tealAccent,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Text("$itemId"),
                                  ),
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 15.0, left: 14.0, bottom: 5.0),
                                    child: Text(
                                      "Payment Method",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.tealAccent,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Text("$paymentValue"),
                                  ),
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 15.0, left: 14.0, bottom: 5.0),
                                    child: Text(
                                      "Total Bill",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 10.0, right: 10.0),
                                  child: Container(
                                      width: double.infinity,
                                      height: 125,
                                      decoration: BoxDecoration(
                                          color: Colors.tealAccent,
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: Text("data")),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 65,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            String productId,
                                                sellerId,
                                                addressId,
                                                paymentType;
                                            productId = state.orderModel
                                                .productModel.productId!;
                                            addressId = state.orderModel
                                                .addressModel[0].addressId!;
                                            sellerId = state.orderModel
                                                .productModel.sellerId!;
                                            paymentType = paymentValue!;
                                            int quantity = 1;
                                            num? totalBill = state
                                                .orderModel.billModel.totalBill;
                                            await OrderScreenApis().placeOrder(
                                                productId,
                                                addressId,
                                                quantity,
                                                sellerId,
                                                paymentType,
                                                totalBill!);
                                          },
                                          child: const Text(
                                            "Confirm Order",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else if (state is ErrorLoadingStateForOrderScreen) {
                          return Center(child: Text(state.error.toString()));
                        } else {
                          return const Center(
                              child: Text("Something Went Wrong"));
                        }
                      },
                    );
                  } else {
                    return AddressSubmitionScreen();
                  }
                } else {
                  return const Center(
                    child: Text("Error"),
                  );
                }
              },
            )));
  }
}
