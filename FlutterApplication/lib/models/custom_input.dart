import 'package:flutter/material.dart';

class CustomTextInp {
  // Objects the class instantiate
  String hintText;
  Icon icon;
  String pervious;
  String value;
  bool secured;
  bool showPass;

// Object intialization
  CustomTextInp(
      {this.hintText,
      this.icon,
      this.pervious = "",
      this.secured = false,
      this.showPass = false,
      this.value = ""});
}
