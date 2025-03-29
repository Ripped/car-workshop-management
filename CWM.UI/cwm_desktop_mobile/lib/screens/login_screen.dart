import 'package:cwm_desktop_mobile/models/user_auth.dart';
import 'package:cwm_desktop_mobile/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/utils.dart';
import '../widgets/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  late AuthProvider _authProvider;
  UserAuth? userResponse;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _authProvider = context.read<AuthProvider>();
  }

  Future<void> getData() async {
    userResponse = await _authProvider.login();
  }

  Future _loginSubmit() async {
    userResponse = await _authProvider.login();

    userResponse = null;

    var username = _usernameController.text;
    var password = _passwordController.text;

    if (username == "" || password == "") {
      String errorMessage = "Unesite korisničko ime i lozinku!";

      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Greška!"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: const Text("OK"),
                ),
              ],
            );
          });
    } else {
      Authorization.username = username;
      Authorization.password = password;

      await getData();

      if (userResponse != null) {
        Authorization.userId = userResponse!.id;
        Authorization.roles = userResponse!.roles;

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
          (route) => false,
        );
      } else {
        String errorMessage =
            "Netačno korisničko ime ili lozinka. Molimo pokušajte ponovo.";

        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Greška!"),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    child: const Text("OK"),
                  ),
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: 400,
              maxHeight: (Responsive.isMobile(context) ? 600 : 400)),
          child: !Responsive.isMobile(context)
              ? Card(
                  elevation: 2,
                  child: _buildLoginForm(context),
                )
              : _buildLoginForm(context),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset("assets/images/logo.png", width: 250, height: 150),
          if (Responsive.isMobile(context)) const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                      labelText: "Korisnicko ime*",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder()),
                  controller: _usernameController,
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                      labelText: "Password*",
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder()),
                  controller: _passwordController,
                  obscureText: true,
                  onSubmitted: (value) => _loginSubmit(),
                ),
              ],
            ),
          ),
          OutlinedButton(
            style: const ButtonStyle(
                padding: WidgetStatePropertyAll(
                    EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20))),
            onPressed: _loginSubmit,
            child: const Text("PRIJAVA"),
          )
        ],
      ),
    );
  }

  /*Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: SizedBox(
          width: 500,
          height: 600,
          child: Card(
            color: Colors.grey[200],
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Image(
                      width: 180,
                      height: 180,
                      image: AssetImage('assets/images/logo.png')),
                  Divider(
                    height: 80.0,
                    color: Colors.grey[400],
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        labelText: 'Korisnicko ime',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email)),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: _isObscured,
                    decoration: InputDecoration(
                      labelText: 'Lozinka',
                      suffixIcon: IconButton(
                        icon: Icon(_icon),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                            _icon = _isObscured
                                ? Icons.visibility_off
                                : Icons.visibility;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.password),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  buildLogin(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const DashboardScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      'Nemate račun? Registruj se!',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade900),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );*/

  ElevatedButton buildLogin() {
    return ElevatedButton(
      onPressed: () async {
        userResponse = null;

        var username = _usernameController.text;
        var password = _passwordController.text;

        if (username == "" || password == "") {
          String errorMessage = "Unesite korisničko ime i lozinku!";

          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Greška!"),
                  content: Text(errorMessage),
                  actions: [
                    TextButton(
                      onPressed: () => {Navigator.of(context).pop()},
                      child: const Text("OK"),
                    ),
                  ],
                );
              });
        } else {
          Authorization.username = username;
          Authorization.password = password;

          await getData();

          if (userResponse != null) {
            Authorization.userId = userResponse!.id;
            Authorization.roles = userResponse!.roles;

            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
              (route) => false,
            );
          } else {
            String errorMessage =
                "Netačno korisničko ime ili lozinka. Molimo pokušajte ponovo.";

            // ignore: use_build_context_synchronously
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Greška!"),
                    content: Text(errorMessage),
                    actions: [
                      TextButton(
                        onPressed: () => {Navigator.of(context).pop()},
                        child: const Text("OK"),
                      ),
                    ],
                  );
                });
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[400],
        foregroundColor: Colors.white,
        minimumSize: const Size(120, 50),
        textStyle: const TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 2.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 5.0,
      ),
      child: const Text('Prijava'),
    );
  }
}
