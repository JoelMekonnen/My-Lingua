import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/providers/auth.dart';
import 'package:my_lingua/widgets/custom_text.dart';

class ErrorMessage extends StatelessWidget {
  // Status check to know the error message
  final Status check;
  // The error message that comes from the server
  final List response;
  // define if the message appear on the top of the form or not
  final bool top;
  ErrorMessage({this.check, this.response, this.top = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:
          // To display error when there is no connection to server
          this.top && check == Status.Failed
              ? CustomText(
                  text: "Connection Failed",
                  color: red,
                )
              :
              // Check if the error is an unauthenticated
              (!this.top && check == Status.Unauthenticated
                  ? CustomText(
                      text: response != null ? response[0] : "",
                      color: red,
                    )
                  : Container()),
    );
  }
}
