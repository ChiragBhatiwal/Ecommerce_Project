import 'package:ecommerce_flutter/Views/Screens/SellerAccount_AdminPanel/OrderStatusScreenComponents/AcceptedOrders.dart';
import 'package:ecommerce_flutter/Views/Screens/SellerAccount_AdminPanel/OrderStatusScreenComponents/DeliveredItemsScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/SellerAccount_AdminPanel/OrderStatusScreenComponents/PendingItemsScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/SellerAccount_AdminPanel/OrderStatusScreenComponents/RejectedOrders.dart';
import 'package:flutter/material.dart';

class ItemsStatusScreen extends StatefulWidget {
  const ItemsStatusScreen({super.key});

  @override
  State<ItemsStatusScreen> createState() => _ItemsStatusScreenState();
}

class _ItemsStatusScreenState extends State<ItemsStatusScreen> {
  int currentIndexScreen = 0;
  List<Widget> screens = [
    const PendingItemsScreen(),
    const Acceptedorders(),
    const DeliveredItemsScreen(),
    const RejectedOrders()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Items-Status", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: screens[currentIndexScreen],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black26,
        selectedItemColor: Colors.lightBlue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pending), label: "Pending"),
          BottomNavigationBarItem(
              icon: Icon(Icons.gpp_good), label: "Confirmed"),
          BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining_rounded), label: "Delivered"),
          BottomNavigationBarItem(
              icon: Icon(Icons.dangerous_outlined), label: "Reject/Refunded"),
        ],
        currentIndex: currentIndexScreen,
        onTap: (index) {
          setState(() {
            currentIndexScreen = index;
          });
        },
      ),
    );
  }
}
