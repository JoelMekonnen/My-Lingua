import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/models/course.dart';
import 'package:my_lingua/providers/auth.dart';
import 'package:my_lingua/providers/content.dart';
import 'package:my_lingua/providers/course.dart';
import 'package:my_lingua/screens/loading.dart';
import 'package:my_lingua/screens/text_course.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:transparent_image/transparent_image.dart';

class ProgressWidget extends StatelessWidget {
  final CourseModel courseModel;
  final ContentProvider content;
  final AuthProvider auth;
  final CourseProvider course;
  ProgressWidget({this.courseModel, this.content, this.auth, this.course});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(color: grey, offset: Offset(1, 1), blurRadius: 1),
              ],
              borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.padding),
                ),
                title: Text(courseModel.courseName),
                subtitle: Text("70% progress"),
                trailing: Icon(Icons.share),
              ),
              Container(
                height: 300,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.center,
                      child: LoadingScreen(),
                    )),
                    FadeInImage.memoryNetwork(
                        width: double.infinity,
                        fit: BoxFit.fill,
                        placeholder: kTransparentImage,
                        image: courseModel.courseImage),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: CustomText(
                  text: courseModel.courseDesc,
                  size: 17,
                  color: grey,
                ),
              ),
              Row(children: [
                TextButton(
                  onPressed: () async {
                    await this
                        .content
                        .getContent(course, courseModel.courseID, 1);
                    var current =
                        content.getCurrent(content.list[0]['currContentId']);
                    print(content.list);
                    changeScreen(context,
                        TextCourseScreen(courseModel.courseID, current));
                  },
                  child: CustomText(
                    text: "CONTINUE",
                    size: 20,
                    color: blue,
                    weight: FontWeight.w600,
                  ),
                ),
              ]),
            ],
          ),
        ));
  }
}
