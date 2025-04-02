import 'package:ecommerce_flutter/ViewModels/Bloc/UserInformationScreen/UserInfoBloc.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/UserInformationScreen/UserInfoEvent.dart';
import 'package:ecommerce_flutter/ViewModels/Bloc/UserInformationScreen/UserInfoState.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/AddressSelectionScreen.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/PreviousAndCurrentOrderShowingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAccountInformationScreen extends StatelessWidget {
  const UserAccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfoBloc = context.read<UserInfoBloc>();
    if (userInfoBloc.state is! LoadedState_UserInfoState) {
      userInfoBloc.add(RequestUserInfoEvent());
    }
    var _media = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Account Info",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (context, state) {
                      if (state is LoadingState_UserInfoState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is LoadedState_UserInfoState) {
                        return portraitUserAccountInfo(
                            context, _media.size, state);
                      } else if (state is FailedState_UserInfoState) {
                        return Center(
                          child: Text(state.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: Text("Failed To Load Data"),
                        );
                      }
                    },
                  );
                } else {
                  return landscapeUserAccountInfo();
                }
              },
            )));
  }

  String formatDateTime(String createdAt) {
    DateTime dateTime = DateTime.parse(createdAt).toLocal();
    return "${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }

  Widget portraitUserAccountInfo(
      BuildContext context, Size size, LoadedState_UserInfoState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Personal Information Of User
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //-------------Headding------------------
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 5.0),
                  child: Text(
                    "Personal Information",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                //---------------Content-Box-----------------
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                  child: Container(
                    width: size.width * 1,
                    child: Column(
                      children: [
                        //Name Showing Comaponent
                        Row(
                          children: [
                            const Text(
                              "Name :- ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              state.userInformationModel!.username.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Email :- ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              state.userInformationModel!.email.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            //Showing Name and Giving Option to Update
                            const Text(
                              "Joined :- ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              "${state.userInformationModel!.createdAt.day}-${state.userInformationModel!.createdAt.month}-${state.userInformationModel!.createdAt.year},${state.userInformationModel!.createdAt.hour}:${state.userInformationModel!.createdAt.minute}",
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 4.0, bottom: 4.0, right: 5.0),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "Update Information",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.cyan,
                                  fontSize: 17,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        //Orders Information
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
              height: size.height * 0.1,
              width: size.width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0))),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "Orders",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0))),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "Buy-Again",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        //Reset Password
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: size.height * 0.08,
            width: size.width * 1,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.cyanAccent),
                borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Reset Password",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.arrow_forward_ios_outlined),
                )
              ],
            ),
          ),
        ),
        //Manage Address
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddressSelectionScreen(),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: size.height * 0.08,
              width: size.width * 1,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyanAccent),
                  borderRadius: BorderRadius.circular(5.0)),
              child: const Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Manage Address",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.arrow_forward_ios_outlined),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget landscapeUserAccountInfo() {
    return Center(
      child: Text("Todo"),
    );
  }
}
