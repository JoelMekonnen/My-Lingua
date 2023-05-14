import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_lingua/helpers/constant.dart';
import 'package:my_lingua/models/content.dart';
import 'package:http/http.dart' as http;
import 'package:my_lingua/providers/course.dart';

enum ContentStatus {
  Uninitialized,
  Unauthenticated,
  Authentcating,
  Authenticated,
  Failed
}

class ContentProvider with ChangeNotifier {
  // the content tha we got from course
  List<ContentModel> _contentModel;
  ContentModel _currentModel;
  ContentStatus _status = ContentStatus.Uninitialized;
  List _list;

  // getters
  List<ContentModel> get contentModel => _contentModel;
  ContentStatus get status => _status;
  ContentModel get currentModel => _currentModel;
  List get list => _list;

  Future<bool> getContentTile(int contentID) async {
    _status = ContentStatus.Authentcating;
    notifyListeners();
    var tokenKey = await FlutterSession().get("tokenKey");
    // url to get contents
    final contentURL = "$ip/user/course/content/$contentID";
    try {
      // response in getting contents
      final response = await http.get(
        contentURL,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $tokenKey'
        },
      );
      // if we got good response
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        _status = ContentStatus.Authenticated;
        return true;
      }
      // any other responses
      else {
        return false;
      }
    }
    // if no connection is not occur
    catch (e) {
      notifyListeners();
      return false;
    }
  }

  Future<bool> isCompleted(
      CourseProvider course, ContentModel content, int courseID) async {
    _status = ContentStatus.Authentcating;
    notifyListeners();
    var tokenKey = await FlutterSession().get("tokenKey");
    var userID = await FlutterSession().get("userID");

    Map<String, dynamic> completeData = {
      "contentId": content.contentID + 1,
      "userId": userID,
    };
    // url to get contents
    final contentURL = "$ip/user/course/content/takes/";
    try {
      // response in getting contents
      final response = await http.post(contentURL,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Token $tokenKey'
          },
          body: json.encode(completeData));
      print(response.body);
      // if we got good response
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        this.getContent(course, courseID, content.contentLevel);
        // var data = json.decode(response.body) as List;
        // _contentModel =
        //     data.map<ContentModel>((e) => ContentModel.fromJson(e)).toList();
        // _currentModel = _contentModel[0];
        // _status = ContentStatus.Authenticated;
        return true;
      }
      // any other responses
      else {
        return false;
      }
    }
    // if no connection is not occur
    catch (e) {
      notifyListeners();
      return false;
    }
  }

  ContentModel getCurrent(int contentID) {
    for (int i = 0; i < contentModel.length; i++) {
      if (contentModel[i].contentID == contentID) {
        return contentModel[i];
      }
    }
    return null;
  }

  Future<bool> getContent(
      CourseProvider course, int courseID, int contentLevel) async {
    _status = ContentStatus.Authentcating;
    notifyListeners();
    var tokenKey = await FlutterSession().get("tokenKey");
    // url to get contents
    final contentURL =
        "$ip/user/course/content/?courseId=$courseID&contentLevel=$contentLevel";
    final statusURL = "$ip/user/course/enroll/status";
    try {
      // response in getting contents
      final response = await http.get(
        contentURL,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $tokenKey'
        },
      );
      final responseStatus = await http.get(
        statusURL,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $tokenKey'
        },
      );
      // if we got good response
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        course.setCurrentCourse(courseID);
        var data = json.decode(response.body) as List;
        var dataStatus = json.decode(responseStatus.body);
        _list = dataStatus;
        _contentModel =
            data.map<ContentModel>((e) => ContentModel.fromJson(e)).toList();
        _currentModel = _contentModel[0];
        _status = ContentStatus.Authenticated;
        return true;
      }
      // any other responses
      else {
        return false;
      }
    }
    // if no connection is not occur
    catch (e) {
      notifyListeners();
      return false;
    }
  }
}
