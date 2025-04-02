import 'package:ecommerce_flutter/ViewModels/Bloc/SearchScreen/SearchBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/SearchScreen/SearchEvent.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/HomeScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/ManageAccountScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Services/Socket/Sockets.dart';
import '../../../Utils/Flutter_Storage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndexValue = 0;
  List<StatelessWidget> Screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    void makeSocketInstance() async {
      String token;
      token = await FlutterStorage().readData() ?? "";
      if (token.isNotEmpty) {
        await SocketService().connect(token);
      }
    }

    makeSocketInstance();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndexValue != 0) {
          setState(() {
            currentIndexValue = 0; // Navigate to the first tab
          });
          return false; // Prevent the app from closing
        }
        return true; // Allow the app to close
      },
      child: Scaffold(
        body: Screens[currentIndexValue],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentIndexValue = index;
              });

              if (index == 1) {
                context.read<SearchBloc>().add(ResetSearchStateEvent());
              }
            },
            currentIndex: currentIndexValue,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: "Profile"),
            ]),
      ),
    );
  }
}
