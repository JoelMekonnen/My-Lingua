import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final double size;
  final Color color;
  final TextAlign align;
  final double pad;
  CustomText({
    @required this.text,
    this.weight,
    this.size,
    this.color,
    this.align,
    this.pad
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(pad??0),
        child: Text(
          text,
          style: TextStyle(
            color: color ?? black,
            fontWeight: weight ?? FontWeight.normal,
            fontSize: size ?? 16,
          ),
          textAlign: align ?? TextAlign.start,
        ));
  }
}
