import 'package:ecommerce_flutter/Models/CartScreenModels.dart';
import 'package:ecommerce_flutter/Services/Api/CartScreenApis.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/CartScreen/CartBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/CartScreen/CartEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/CartScreen/CartState.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/ProductDetailShowingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  String formatPrice(int price) {
    final numberFormat = NumberFormat("#,##,##0", "en_IN");
    return numberFormat.format(price);
  }

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    if (cartBloc.state is! ProductLoadedCartScreenState) {
      cartBloc.add(RequestCartProductsEvent());
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 25,
          title: const Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: Text("Shopping Cart"),
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is ProductLoadingCartScreenState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductLoadedCartScreenState) {
              List<CartScreenModel> cartScreenModel = state.productList;

              if (cartScreenModel.isEmpty) {
                return const Center(
                  child: Text("Cart Is Empty"),
                );
              } else {
                return ListView.builder(
                  itemCount: state.productList.length,
                  itemBuilder: (context, index) {
                    CartScreenModel products = cartScreenModel[index];
                    String productImageUrl = products
                                .productImage?.isNotEmpty ??
                            false
                        ? products.productImage![0]
                        : 'https://via.placeholder.com/150'; // Placeholder image if no image is available

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsScreen(id: products.productId),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          height: 200,
                          width: double.infinity,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 145,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(7.0),
                                      ),
                                      child: Image.network(
                                        productImageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(Icons.error);
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 160,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              products.productName.toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "₹${formatPrice(products.productPrice!.toInt())}",
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              products.productShortDesc
                                                  .toString(),
                                              maxLines: 5,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                bottom: -5,
                                right: 8,
                                child: IconButton(
                                  color: Colors.redAccent,
                                  onPressed: () async {
                                    try {
                                      await CartScreenApis
                                          .deleteProductFromCart(products.sId!);
                                      // Optionally show a snackbar or feedback message
                                    } catch (e) {
                                      // Show an error message in case of failure
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Failed to delete product")),
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                      size: 30.0, Icons.delete_outlined),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            } else if (state is ErrorLoadingProductCartScreenState) {
              return Center(
                child: Text(state.error.toString()),
              );
            } else {
              return const Center(
                child: Text("Error 404"),
              );
            }
          },
        ),
      ),
    );
  }
}
