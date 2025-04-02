import "package:ecommerce_flutter/Services/Api/LoginScreenApis.dart";
import "package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/BottomNavigation_MainScreen.dart";
import "package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/SignupScreen.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObsecure = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: CircleAvatar(
                  radius: 70.0,
                  child: ClipOval(
                    child: Image.asset(
                      fit: BoxFit.cover,
                      "assets/logo_flutter.jpg",
                      width: 140,
                      height: 140,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, right: 22.0, left: 22.0),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle_sharp,
                                  size: 30.0,
                                ),
                                hintText: "username",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black45,
                                  width: 2,
                                ))),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _isObsecure,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObsecure = !_isObsecure;
                                    });
                                  },
                                  icon: Icon(
                                    _isObsecure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                suffixIconConstraints: const BoxConstraints(
                                  minWidth: 48, // Same as prefixIcon
                                  minHeight: 48,
                                ),
                                prefixIcon: const Icon(
                                  Icons.account_circle_sharp,
                                  size: 30.0,
                                ),
                                hintText: "password",
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black45,
                                  width: 2,
                                ))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    late String username, password;
                    username = _usernameController.text;
                    password = _passwordController.text;
                    print('username is $username,password is $password');
                    int response =
                        await LoginScreenApis.loginUser(username, password);
                    print(response.toString());
                    if (response == 1) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ));
                    }
                  },
                  child: const Text("Login")),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RichText(
                    text: TextSpan(
                        text: "Don't Have An Account ?",
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                      TextSpan(
                        text: " SignUp.",
                        style: const TextStyle(
                            color: Colors.lightBlueAccent, fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                      )
                    ])),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
