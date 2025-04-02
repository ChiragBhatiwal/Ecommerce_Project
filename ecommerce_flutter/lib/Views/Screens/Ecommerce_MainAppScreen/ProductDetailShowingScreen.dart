import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_flutter/Models/ProductDetailScreenModel.dart';
import 'package:ecommerce_flutter/Services/Api/CartScreenApis.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/ProductDetailScreen/ProductDetailBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/ProductDetailScreen/ProductDetailEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/ProductDetailScreen/ProductDetailState.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/CartScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/PlaceOrderComponents/PlaceOrderScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  String? id;
  ProductDetailsScreen({super.key, required this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductDetailBloc>(context)
        .add(FetchProductDetails(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
              builder: (context, state) {
                if (state is InitialProductLoadingStateProductDetailsScreen) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadingProductStateProductDetailsScreen) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedProductStateProductDetailScreen) {
                  ProductDetailScreenModel data = state.data;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Product Name Text
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 10.0),
                          child: Text(
                            data.productName.toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        //Short Description
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 10.0),
                          child: Text(
                            data.productShortDesc.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                        ),
                        //Image Carousel
                        CarouselSlider(
                            items: data.productImage!
                                .map((items) => Image.network(
                                      items.toString(),
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                    ))
                                .toList(),
                            options: CarouselOptions()),
                        //Product Price Text
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: Text(
                            "₹${data.productPrice.toString()}",
                            style: const TextStyle(
                                fontSize: 24, color: Color(0xFF4CAF50)),
                          ),
                        ),
                        //Text Heading of About
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 10.0),
                          child: Text(
                            "About this Item",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        //Description Of an Item
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 5.0, top: 5.0),
                          child: Text(
                            textAlign: TextAlign.start,
                            data.productRichDesc.toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        //Cart And Buy Button
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PlaceOrderScreen(
                                                itemId: data.sId,
                                              ),
                                            ));
                                      },
                                      child: const Text("Buy Now")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        int result = await CartScreenApis
                                            .addProductInCart(data.sId!);

                                        if (result == 1) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const CartScreen(),
                                              ));
                                        }
                                      },
                                      child: const Text("Add To Cart")),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is ErrorLoadingProductDetailScreen) {
                  return Center(
                      child: Text(state.error.toString(),
                          style: const TextStyle(color: Colors.black)));
                } else {
                  return const Center(
                    child: Text(
                      "Something Went Wrong!",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
              },
            )));
  }
}
