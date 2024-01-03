import 'package:cwm_desktop_mobile/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.png",
                        width: 200, height: 200),
                    const TextField(
                      decoration: InputDecoration(
                          labelText: "Email*", prefixIcon: Icon(Icons.email)),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(
                          labelText: "Password*",
                          prefixIcon: Icon(Icons.password)),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          print("Login");

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MasterScreen("", DashboardScreen())));
                        },
                        child: Text("Login"))
                  ],
                ),
              ),
            )));
  }
}
