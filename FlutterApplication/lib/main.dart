import 'package:flutter/material.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/providers/auth.dart';
import 'package:my_lingua/providers/content.dart';
import 'package:my_lingua/providers/course.dart';
import 'package:my_lingua/screens/home_loading.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CourseProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ContentProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Lingua',
      theme: ThemeData(
        primarySwatch: lightBlue,
        accentColor: lightBlue1,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: HomeLoading(),
    );
  }
}
