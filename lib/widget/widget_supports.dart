import 'package:flutter/material.dart';

class Appwidget {
  static TextStyle boldTextFeildStyle() {
    return TextStyle(
      fontSize: 20.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: 'poppins',
    );
  }

  static TextStyle HeadlineTextFeildStyle() {
    return TextStyle(
      fontSize: 24.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: 'poppins',
    );
  }

  static TextStyle LightTextFeildStyle() {
    return TextStyle(
      fontSize: 15.0,
      color: Colors.black54,
      fontWeight: FontWeight.w500,
      fontFamily: 'poppins',
    );
  }

  static TextStyle semiBoldTextFeildStyle() {
    return TextStyle(
      fontSize: 18.0,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: 'poppins',
    );
  }

  static TextStyle loginBoldTextFeildStyle() {
    return TextStyle(
      fontSize: 18.0,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
      fontFamily: 'poppins',
      decoration: TextDecoration.underline,
      // 👈 adds underline
      decorationColor: Colors.black,
      // optional: underline color
      decorationThickness: 1.2, // optional: underline thickness
    );
  }
}
