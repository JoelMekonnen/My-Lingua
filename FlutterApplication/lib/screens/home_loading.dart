import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/providers/auth.dart';
import 'package:my_lingua/providers/course.dart';
import 'package:my_lingua/screens/loading.dart';
import 'package:provider/provider.dart';

class HomeLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
    var course = Provider.of<CourseProvider>(context);
    auth.sessionCheck(course);
    return auth.screen ??
        Container(
          color: white,
          child: LoadingScreen(),
        );
  }
}
