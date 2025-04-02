import 'package:ecommerce_flutter/Models/SearchScreenModels.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/SearchScreen/SearchBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/SearchScreen/SearchEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/SearchScreen/SearchState.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/ProductDetailShowingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  String formatPrice(int price) {
    final numberFormat = NumberFormat("#,##,##0", "en_IN");
    return numberFormat.format(price);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController InputController = TextEditingController();

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
            child: SizedBox(
              height: 60,
              child: TextField(
                controller: InputController,
                onSubmitted: (value) {
                  BlocProvider.of<SearchBloc>(context)
                      .add(FetchSearchProductsEvent(value: value));
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 2)),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is InitialLoadingSearchProductsState) {
                  return const Center(
                    child: Text("Let's Start Finding Product."),
                  );
                } else if (state is LoadingSearchProductState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoadedSearchProductsState) {
                  List<SearchScreenModel> data = state.data;
                  return ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        SearchScreenModel products = data[index];
                        // Default placeholder image
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailsScreen(id: products.sId),
                                  ));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white54,
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(8.0)),
                                height: 175,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: double.infinity,
                                      width: 145,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(7.0),
                                            bottomLeft: Radius.circular(7.0)),
                                        child: Image.network(
                                            fit: BoxFit.cover,
                                            products.productImage![0]),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: SizedBox(
                                        height: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                products.productName.toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "₹${formatPrice(products.productPrice!.toInt())}",
                                                  style:
                                                      TextStyle(fontSize: 18),
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
                                )),
                          ),
                        );
                      });
                } else if (state is ErrorLoadingSearchProductsState) {
                  String error = state.error.toString();
                  return Center(
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Failed To Fetch",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
