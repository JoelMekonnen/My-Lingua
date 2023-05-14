import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
// import 'package:my_lingua/providers/auth.dart';
import 'package:my_lingua/providers/course.dart';
import 'package:my_lingua/screens/progress.dart';
import 'package:my_lingua/screens/quiz.dart';
import 'package:my_lingua/widgets/custom_label.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final course = Provider.of<CourseProvider>(context);
    // final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: lightBlue,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(75),
                          ),
                        ),
                        CustomText(
                          text: "ዮሐንስ",
                          pad: 20,
                        )
                      ],
                    ),
                    CustomText(
                      text: "yohannesaber1236@gmail.com",
                      pad: 5,
                    ),
                    CustomText(
                      text: "Current Level: 4",
                      pad: 5,
                    ),
                    CustomText(
                      text: "Courses: 3",
                      pad: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              CustomLabel(
                text: "Courses",
                function: () {
                  course.getCourse();
                  changeScreen(context, ProgressScreen());
                },
              ),
              CustomLabel(
                text: "Quizes",
                function: () => changeScreen(context, QuizScreen()),
              ),
              CustomLabel(
                text: "Practices",
              ),
              CustomLabel(
                text: "Games",
              ),
              CustomLabel(
                text: "Certificates",
              ),
              CustomLabel(
                text: "Progress",
              ),
              CustomLabel(
                text: "Bookmarks",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
