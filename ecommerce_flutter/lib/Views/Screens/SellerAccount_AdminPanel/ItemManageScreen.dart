import 'package:ecommerce_flutter/Models/ItemManagedScreenModel.dart';
import 'package:ecommerce_flutter/Services/Api/ItemManagedScreenApis.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/ItemManagedScreen/ItemManagedBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/ItemManagedScreen/ItemManagedEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/ItemManagedScreen/ItemManagedState.dart';
import 'package:ecommerce_flutter/Views/Screens/SellerAccount_AdminPanel/UpdateItemScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ItemManageScreen extends StatelessWidget {
  const ItemManageScreen({super.key});

  String formatPrice(int price) {
    final numberFormat = NumberFormat("#,##,##0", "en_IN");
    return numberFormat.format(price);
  }

  @override
  Widget build(BuildContext context) {
    final myBloc = context.read<ItemManagedBloc>();
    if (myBloc.state is! ItemManagedLoadedState) {
      myBloc.add(RequestItemsForItemMangedScreen());
    }

    return SafeArea(child: Scaffold(
      body: Center(
        child: BlocBuilder<ItemManagedBloc, ItemManagedStates>(
          builder: (context, state) {
            if (state is ItemManagedLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ItemManagedLoadedState) {
              List<ItemManagedScreenModel> itemList = state.itemsList;
              return ListView.builder(
                  itemCount: state.itemsList.length,
                  itemBuilder: (context, index) {
                    ItemManagedScreenModel products = itemList[index];
                    // Default placeholder image
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(8.0)),
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
                                          fit: BoxFit.cover,
                                          products.productImage![0].toString()),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 220,
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "₹${formatPrice(products.productPrice!.toInt())}",
                                                style: TextStyle(fontSize: 18),
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
                                bottom: -10,
                                right: -10,
                                child: PopupMenuButton<String>(
                                  onSelected: (String value) {
                                    if (value == "Edit") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateItemScreen(
                                                    product: products),
                                          ));
                                    } else if (value == "Delete") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text("Are You Sure?"),
                                        behavior: SnackBarBehavior.floating,
                                        action: SnackBarAction(
                                          label: "Yes",
                                          onPressed: () {
                                            ItemManagedScreenApis.deleteProduct(
                                                products.sId!);
                                          },
                                        ),
                                      ));
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem<String>(
                                      value: "Edit",
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: "Delete",
                                      child: Text("Delete"),
                                    ),
                                  ],
                                  icon: const Icon(
                                    size: 30.0,
                                    Icons.more_vert,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
                  });
            } else if (state is ItemManagedLoadingFailed) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const Center(
                child: Text("Something Went Wrong While Loading"),
              );
            }
          },
        ),
      ),
    ));
  }
}
