import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/widgets/custom_text.dart';

class CustomTile extends StatefulWidget {
  final String text;
  final Color color;
  final int id;
  final FontWeight fontWeight;
  final Function function;
  final double fontsize;
  final bool selected;
  final IconData progress;
  CustomTile(
      {@required this.text,
      this.color,
      @required this.id,
      this.function,
      this.selected = false,
      this.fontWeight,
      this.fontsize,
      this.progress});
  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          border:
              widget.selected ? Border.all(color: blue, width: 4) : Border(),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          CustomText(
            text: widget.text,
            align: TextAlign.center,
            weight: widget.fontWeight ?? FontWeight.normal,
            size: widget.fontsize ?? 16,
          ),
          Icon(widget.progress, color: widget.progress == Icons.lock ? grey : blue,)
          // x < widget.contentModel.contentLevel
          //     ? Icon(Icons.verified)
          //     : Icon(Icons.lock)
        ]),
      ),
    );
  }
}
