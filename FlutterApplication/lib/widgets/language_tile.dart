import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/models/course.dart';
import 'package:my_lingua/widgets/custom_text.dart';

class LanguageList extends StatefulWidget {
  final bool selected;
  final Function function;
  final int id;
  final CourseModel courseModel;
  LanguageList({this.selected, this.function, this.id, this.courseModel});
  @override
  _LanguageListState createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.function,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: blue,
                    border: widget.courseModel.selected
                        ? Border.all(color: black, width: 5)
                        : Border(),
                      image: DecorationImage(image: AssetImage("assets/images/undraw_secure_login_pdn4.png"),)
                  ),
                ),
                Positioned(
                  top: 60,
                  child: Container(
                    width: 151,
                    height: 30,
                    color: white,
                    child: Center(
                      child: CustomText(
                        text: widget.courseModel.courseName,
                        align: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
