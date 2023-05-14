import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_lingua/helpers/constant.dart';
import 'package:my_lingua/models/course.dart';
import 'package:http/http.dart' as http;

enum CourseStatus {
  Uninitialized,
  Unauthenticated,
  Authentcating,
  Authenticated,
  Failed
}

class CourseProvider with ChangeNotifier {
  // list of course
  List<CourseModel> _courseList;
  CourseStatus _status = CourseStatus.Uninitialized;
  CourseModel _currentCourse;

  // getters
  List<CourseModel> get courseList => _courseList;
  CourseStatus get status => _status;
  CourseModel get currentCourse => _currentCourse;

  // url to get courses
  final courseURL = "$ip/user/course/";
  final enrollURL = "$ip/user/course/enroll/";

  enroll(int courseID) async {
    _status = CourseStatus.Authentcating;
    notifyListeners();
    var tokenKey = await FlutterSession().get('tokenKey');
    Map<String, dynamic> enrollData = {'courseId': courseID};
    final response = await http.post(enrollURL,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $tokenKey'
        },
        body: json.encode(enrollData));
    print(response.body);
    _status = CourseStatus.Authenticated;
  }

  Future<bool> getCourse() async {
    _status = CourseStatus.Authentcating;
    notifyListeners();
    var tokenKey = await FlutterSession().get('tokenKey');
    try {
      //
      final response = await http.get(courseURL, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $tokenKey'
      });
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var data = json.decode(response.body) as List;
        this._courseList =
            data.map((json) => CourseModel.fromJson(json)).toList();
        _status = CourseStatus.Authenticated;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _status = CourseStatus.Failed;
      notifyListeners();
      return false;
    }
  }

  Future<bool> setCurrentCourse(int courseID) async {
    for (int i = 0; i < courseList.length; i++) {
      if (courseList[i].courseID == courseID) {
        _currentCourse = courseList[i];
        return true;
      }
    }
    return false;
  }
}
