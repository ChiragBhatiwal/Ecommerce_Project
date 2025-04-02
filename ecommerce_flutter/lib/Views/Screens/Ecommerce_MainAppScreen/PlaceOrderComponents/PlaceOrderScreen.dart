import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/PlaceOrderComponents/PaymentMethodScreen.dart';
import 'package:flutter/material.dart';

class PlaceOrderScreen extends StatelessWidget {
  final String? itemId;
  const PlaceOrderScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PaymentMethodScreen(
        itemId: itemId!,
      ),
    );
  }
}
