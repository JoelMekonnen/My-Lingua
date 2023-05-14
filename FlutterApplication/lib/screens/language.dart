import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/models/course.dart';
import 'package:my_lingua/providers/course.dart';
import 'package:my_lingua/screens/course_detail.dart';
import 'package:my_lingua/widgets/custom_btn.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:my_lingua/widgets/language_tile.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  CourseModel selectedCourseModel;
  @override
  Widget build(BuildContext context) {
    final course = Provider.of<CourseProvider>(context);
    if (selectedCourseModel == null) {
      selectedCourseModel = course.courseList[0];
      course.courseList[0].selected = true;
    }
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: course.courseList == null
          ? Container(
              child: Center(
                child: CustomText(text: "No Course is found!"),
              ),
            )
          : Column(
              children: [
                CustomText(
                  text: "Step-1 : choose the language you want to learn",
                  pad: 50,
                  weight: FontWeight.bold,
                  size: 18,
                ),
                Expanded(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(
                      course.courseList.length,
                      (index) {
                        return LanguageList(
                          function: () {
                            setState(
                              () {
                                selectedCourseModel.deselect();
                                course.courseList[index].select();
                                selectedCourseModel = course.courseList[index];
                              },
                            );
                          },
                          courseModel: course.courseList[index],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: CustomButton(
                    text: "choose language",
                    onPressed: () {
                      return changeScreen(
                        context,
                        CourseDetail(selectedCourseModel),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
