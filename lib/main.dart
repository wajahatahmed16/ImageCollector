import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imageCollector/loading/fireload.dart';
import 'package:imageCollector/screens/authentication.dart';
import 'package:imageCollector/screens/login.dart';
import 'package:imageCollector/screens/parts/addPerson.dart';
import 'package:imageCollector/screens/signup.dart';
import 'package:imageCollector/services/authentication_service.dart';
import 'package:imageCollector/wrapper.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider<LoginUser>.value(
              value: AuthService().user,
              child: MaterialApp(
                home: LoginScreen(),
                initialRoute: "wrapper",
                routes: {
                  "loginscreen": (context) => LoginScreen(),
                  "signupscreen": (context) => SignUpScreen(),
                  "authentication": (context) => Authentication(),
                  "wrapper": (context) => Wrapper(),
                  "addperson": (context) => AddPerson(),
                },
              ),
            );
          } else {
            return MaterialApp(
              home: Loading(),
            );
          }
        });
  }
}
