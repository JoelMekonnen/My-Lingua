import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// To change the screen with back option
void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

// To change the screen with no back option
void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}
