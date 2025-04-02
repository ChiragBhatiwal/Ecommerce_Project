import 'package:ecommerce_flutter/ViewModels/Bloc/PanelState/PanelBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/PanelState/PanelEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/PanelState/PanelState.dart';
import 'package:ecommerce_flutter/Views/Screens/SellerAccount_AdminPanel/AddItemScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/SellerAccount_AdminPanel/ItemManageScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/SellerAccount_AdminPanel/ManageSellerAccountScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/SellerAccount_AdminPanel/OrderStatusScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPannelScreen extends StatelessWidget {
  const AdminPannelScreen({super.key});

  Widget buildInfoColumn(String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center, // Align the text in the center
          text: TextSpan(
            children: [
              TextSpan(
                text: label.split(" ")[0], // First word
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: '\n'), // Line break
              TextSpan(
                text: label.split(" ")[1], // Second word
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final panelBloc = context.read<PanelBloc>();
    if (panelBloc.state is! LoadedStateForPanel) {
      panelBloc.add(RequestPanelData());
    }
    final List<String> items = [
      "Orders-Status",
      "Add-Items",
      "Items",
      "Manage Account"
    ];

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Admin Pannel"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          BlocBuilder<PanelBloc, PanelState>(
            builder: (context, state) {
              if (state is LoadingStateForPanel) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedStateForPanel) {
                return SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildInfoColumn("Pending Orders",
                            "${state.pendingOrders.toString()}"),
                        buildInfoColumn("Completed Orders",
                            "${state.completedOrders.toString()}"),
                        buildInfoColumn("Total Revenue",
                            "${state.totalRevenue.toString()}"),
                      ],
                    ));
              } else if (state is FailedToLoadPanelState) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Container(
            color: Colors.black45,
            height: 360,
            width: double.infinity,
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ItemsStatusScreen(),
                          ));
                    } else if (index == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddItemScreen(),
                          ));
                    } else if (index == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ItemManageScreen(),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ManageAccountScreen(),
                          ));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.tealAccent,
                        borderRadius: BorderRadius.circular(15)),
                    height: 100,
                    width: 100,
                    child: Center(
                      child: Text(
                        items[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          const SizedBox(
            height: 50,
            width: double.infinity,
            child: Center(
              child: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
