import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/CartScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/ProductDetailShowingScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Ecommerce"),
            backgroundColor: Colors.lightGreen,
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0.0, 7.0, 0),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ));
                  },
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                height: 240,
                width: double.infinity,
                color: Colors.greenAccent,
                margin: const EdgeInsets.all(3.0),
                child: Image.network(
                    fit: BoxFit.cover,
                    "https://images.pexels.com/photos/3769747/pexels-photo-3769747.jpeg?auto=compress&cs=tinysrgb&w=600"),
              ),
              const SizedBox(
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.start,
                    "Products",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Flexible(
                  child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsScreen(id: "Chirag"),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(8.0)),
                        height: double.infinity,
                        width: 200,
                      ),
                    ),
                  );
                },
              ))
            ],
          )),
    );
  }
}
