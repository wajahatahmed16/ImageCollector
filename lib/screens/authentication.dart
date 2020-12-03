import 'package:flutter/material.dart';
import 'package:imageCollector/screens/login.dart';
import 'package:imageCollector/screens/signup.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showLogin = false;
  void toggleHome() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLogin
        ? LoginScreen(
            toggleHome: toggleHome,
          )
        : SignUpScreen(
            toggleHome: toggleHome,
          );
  }
}
