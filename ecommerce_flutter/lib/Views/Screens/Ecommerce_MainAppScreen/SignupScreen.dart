import 'package:ecommerce_flutter/Services/Api/SignupScreenApis.dart';
import 'package:ecommerce_flutter/Views/Screens/Ecommerce_MainAppScreen/LoginScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

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
                  height: 240,
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
                            controller: _emailController,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  size: 30.0,
                                ),
                                hintText: "email",
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
                            obscureText: true,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: 30.0,
                                ),
                                hintText: "password",
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
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    late String username, email, password;
                    username = _usernameController.text;
                    email = _emailController.text;
                    password = _passwordController.text;
                    int response = await SignupScreenApis.signingupUser(
                        username, email, password);
                    if (response == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    }
                  },
                  child: const Text("SignUp")),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RichText(
                    text: TextSpan(
                        text: "Already Have An Account.",
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                      TextSpan(
                        text: " Login.",
                        style: const TextStyle(
                            color: Colors.lightBlueAccent, fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
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
