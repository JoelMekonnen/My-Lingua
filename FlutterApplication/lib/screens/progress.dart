import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/search.dart';
import 'package:my_lingua/providers/auth.dart';
import 'package:my_lingua/providers/content.dart';
import 'package:my_lingua/providers/course.dart';
import 'package:my_lingua/screens/loading.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:my_lingua/widgets/drawer_widget.dart';
import 'package:my_lingua/widgets/progress_container.dart';
import 'package:provider/provider.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    final course = Provider.of<CourseProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final content = Provider.of<ContentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                List list = course.courseList.map((e) => e.courseName).toList();
                showSearch(
                    context: context,
                    delegate: Search(list));
              })
        ],
      ),
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      body: course.status == CourseStatus.Authentcating
          ? LoadingScreen()
          : (course.status == CourseStatus.Failed
              ? Center(
                  child: CustomText(
                    text: "Connection is failed",
                  ),
                )
              : ListView.builder(
                  itemCount: course.courseList.length,
                  itemBuilder: (context, index) {
                    return ProgressWidget(
                      courseModel: course.courseList[index],
                      content: content,
                      auth: auth,
                      course: course,
                    );
                  },
                )),
    );
  }
}
