import 'package:flutter/material.dart';
import 'package:imageCollector/screens/Home.dart';
import 'package:imageCollector/screens/authentication.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginUser>(context);
    if (user == null) {
      return Authentication();
    } else {
      return Home();
    }
  }
}
