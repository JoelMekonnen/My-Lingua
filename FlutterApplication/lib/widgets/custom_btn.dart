import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/widgets/custom_text.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final double pad;
  CustomButton({@required this.text, this.onPressed, this.color, this.pad});
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed ?? () {},
      child: Container(
        child: CustomText(
          text: widget.text.toUpperCase(),
          color: white,
        ),
        color: widget.color ?? blue,
        padding: EdgeInsets.all(widget.pad ?? 12),
      )
    );
  }
}
