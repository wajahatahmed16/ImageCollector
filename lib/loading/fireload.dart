import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFE6FAFC),
        child: Center(
          child: SpinKitChasingDots(
            color: Color(0xFF507E4E),
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
