import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/models/course.dart';
import 'package:my_lingua/providers/course.dart';
import 'package:my_lingua/screens/loading.dart';
import 'package:my_lingua/screens/progress.dart';
import 'package:my_lingua/widgets/custom_btn.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CourseDetail extends StatelessWidget {
  final CourseModel courseModel;
  CourseDetail(this.courseModel);
  @override
  Widget build(BuildContext context) {
    final course = Provider.of<CourseProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Stack(children: [
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.center,
                        child: LoadingScreen(),
                      )),
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
                    ]),
                  ),
                  CustomText(
                    text: courseModel.courseName,
                    pad: 20,
                    weight: FontWeight.bold,
                    size: 40,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: black),
                    borderRadius: BorderRadius.circular(10)),
                child: CustomText(
                  text: courseModel.courseDesc,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: "enroll",
                    onPressed: () async {
                      await course.enroll(courseModel.courseID);
                      changeScreen(context, ProgressScreen());
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}
