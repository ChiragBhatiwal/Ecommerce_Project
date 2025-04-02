import 'package:ecommerce_flutter/Services/Socket/Sockets.dart';
import 'package:ecommerce_flutter/Utils/Flutter_Storage.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/AddressScreen/AddressBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/CartScreen/CartBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/ItemManagedScreen/ItemManagedBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderScreen/OrderBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderShowingScreen_ManageAccount/OrderShowingBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/OrderStatusScreen/OrderStatusBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/UserInformationScreen/UserInfoBloc.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ViewModels/Bloc/PanelState/PanelBloc.dart';
import 'ViewModels/Bloc/ProductDetailScreen/ProductDetailBloc.dart';
import 'ViewModels/Bloc/SearchScreen/SearchBloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String token;
  token = await FlutterStorage().readData() ?? "";
  if (token.isNotEmpty) {
    await SocketService().connect(token);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => ProductDetailBloc(),
        ),
        BlocProvider(
          create: (context) => ItemManagedBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => AddressBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => OrderStatusBloc(),
        ),
        BlocProvider(
          create: (context) => PanelBloc(),
        ),
        BlocProvider(
          create: (context) => UserInfoBloc(),
        ),
        BlocProvider(
          create: (context) => OrderShowingBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Splashscreen(),
        // ),
      ),
    );
  }
}
