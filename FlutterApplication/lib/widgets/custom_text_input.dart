import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/models/custom_input.dart';


class CustomTextInput extends StatefulWidget {
  final CustomTextInp textInp;
  CustomTextInput(
      {
      this.textInp});
  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
      child: TextFormField(
        obscureText: widget.textInp.secured ? !widget.textInp.showPass : false,
        onSaved: (value) {
          widget.textInp.value = value;
        },
        initialValue: widget.textInp.value,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          icon: widget.textInp.icon,
          fillColor: lightBlue1,
          filled: true,
          hintText: widget.textInp.hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: widget.textInp.secured
              ? IconButton(
                  icon: Icon(widget.textInp.showPass
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      widget.textInp.showPass = !widget.textInp.showPass;
                    });
                  },
                  color: black,
                )
              : null,
        ),
      ),
    );
  }
}
