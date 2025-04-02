import 'package:ecommerce_flutter/Models/AddressScreenModel.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/AddressScreen/AddressBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/AddressScreen/AddressEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/AddressScreen/AddressState.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/AddressSubmitionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressSelectionScreen extends StatelessWidget {
  const AddressSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressBloc = context.read<AddressBloc>();
    if (addressBloc.state is! LoadedUserAddressState) {
      addressBloc.add(RequestUserAddress());
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Select Delivery Address",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state is LoadingUserAddressState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedUserAddressState) {
              List<AddressScreenModel> data = state.addresses;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  data.isEmpty
                      ? Expanded(
                          flex: 9,
                          child: Center(
                            child: Container(
                              width: double.infinity,
                              child: const Text(
                                "Please Add Delivery Address!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      : Flexible(
                          flex: 9,
                          child: Container(
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: state.addresses.length,
                              itemBuilder: (context, index) {
                                AddressScreenModel product = data[index];
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //Title Layout
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  product.title.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              //Rest Address Details Layout
                                              Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: GestureDetector(
                                                  onLongPress: () {
                                                    print("Long Pressed");
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        border: Border.all(
                                                            color:
                                                                Colors.black)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0,
                                                                  top: 4.0),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  text:
                                                                      "Address :-",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  children: <TextSpan>[
                                                                TextSpan(
                                                                    text: product
                                                                        .userAddress
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black))
                                                              ])),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0,
                                                                  top: 4.0),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  text:
                                                                      "City :-",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  children: <TextSpan>[
                                                                TextSpan(
                                                                    text: product
                                                                        .city
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black))
                                                              ])),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0,
                                                                  top: 4.0),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  text:
                                                                      "State :-",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  children: <TextSpan>[
                                                                TextSpan(
                                                                    text: product
                                                                        .state
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black))
                                                              ])),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0,
                                                                  top: 4.0),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  text:
                                                                      "Pincode :-",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  children: <TextSpan>[
                                                                TextSpan(
                                                                    text: product
                                                                        .pincode
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black))
                                                              ])),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0,
                                                                  top: 4.0),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  text:
                                                                      "Country :-",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  children: <TextSpan>[
                                                                TextSpan(
                                                                    text: product
                                                                        .country
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black))
                                                              ])),
                                                        ),
                                                        const Spacer(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0,
                                                                  top: 4.0,
                                                                  bottom: 5.0),
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  text:
                                                                      "Mobile :-",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  children: <TextSpan>[
                                                                TextSpan(
                                                                    text: product
                                                                        .mobile
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black))
                                                              ])),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddressSubmitionScreen(),
                                ));
                          },
                          child: const Text("+ Add New Address")),
                    ),
                  )
                ],
              );
            } else if (state is FailedStateUserAddress) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "Failed to Load Address",
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
          },
        ));
  }
}
