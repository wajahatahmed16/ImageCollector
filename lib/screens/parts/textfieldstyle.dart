import 'package:flutter/material.dart';

const textDecorationStyle = InputDecoration(
  //fillColor: Color(0xFFC7FDC4),
  focusColor: Color(0xFFE6FAFC),
  filled: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
  border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF6BA368),
        width: 10.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0))),
);
