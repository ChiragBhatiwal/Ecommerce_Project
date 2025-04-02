import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/AddressSelectionScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/PreviousAndCurrentOrderShowingScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/UserAccountInformationScreen.dart';
import 'package:flutter/material.dart';

import '../../../Utils/Flutter_Storage.dart';
import '../SellerAccount_AdminPanel/SellerAccount_AdminPanelScreen.dart';
import 'LoginScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage-Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return portraitManageAcountScreen(context);
          } else {
            return landscapeManageAccountScreen();
          }
        },
      ),
    ));
  }

  Widget portraitManageAcountScreen(BuildContext context) {
    return Column(
      children: [
// ------------------->Order Heading<------------------------------
        const SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, top: 5.0),
            child: Text(
              "Orders",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
// Order Manage Layout
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PreviousAndCurrentOrderShowingScreen(
                                    showingScreenId: 0),
                          ));
                    },
                    child: const SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Orders",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 0.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PreviousAndCurrentOrderShowingScreen(
                                    showingScreenId: 1),
                          ));
                    },
                    child: const SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Buy Again",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_right_sharp)
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
// --------------->Account Heading<----------------------------
        const SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, top: 15.0),
            child: Text(
              "Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
//Account Features Box
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.black)),
            width: double.infinity,
            child: Column(
              children: [
//Account-Details
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const UserAccountInformationScreen(),
                        ));
                  },
                  child: const SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "View Account",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right_outlined)
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 0.0,
                  color: Colors.black,
                ),
//Address Manage
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressSelectionScreen(),
                        ));
                  },
                  child: const SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Manage Address",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right_outlined)
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 0.0,
                  color: Colors.black,
                ),
//Seller Account Button (Admin Panel)
                InkWell(
                  child: const SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7.0),
                          child: Text(
                            "Seller Account",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right_rounded)
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminPannelScreen(),
                        ));
                  },
                ),
                const Divider(
                  height: 0.0,
                  color: Colors.black,
                ),
//Logout Button
                InkWell(
                    child: const SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 10.0),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () async {
                      await FlutterStorage().clearData();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    })
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget landscapeManageAccountScreen() {
    return Center(
      child: Text("Todo"),
    );
  }
}
