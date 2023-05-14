import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/widgets/custom_text.dart';

class CustomLabel extends StatefulWidget {
  final String text;
  final Function function;
  CustomLabel({this.text, this.function});
  @override
  _CustomLabelState createState() => _CustomLabelState();
}

class _CustomLabelState extends State<CustomLabel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function ?? () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 20),
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(55),
            border: Border.all(
              color: blue,
              width: 3,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                color: blue,
              ),
              CustomText(
                text: widget.text,
                pad: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
