import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:my_lingua/helpers/constant.dart';
import 'package:my_lingua/models/user.dart';
import 'package:my_lingua/providers/course.dart';
import 'package:my_lingua/screens/home.dart';
import 'package:my_lingua/screens/profile.dart';

// Status of authentication
enum Status {
  Uninitialized,
  Unauthenticated,
  Authentcating,
  Authenticated,
  Failed
}

class AuthProvider with ChangeNotifier {
  // the user that is logined
  UserModel _userModel;
  Widget _screen;
  Status _status = Status.Uninitialized;
  // the key used for authorization
  var tokenKey = "";

  // getters
  UserModel get userModel => _userModel;
  Status get status => _status;
  Widget get screen => _screen;

  // url for getting response
  final loginURL = "$ip/user/rest-auth/login/";
  final registerURL = "$ip/user/registration/";
  final userURL = "$ip/user/";
  final prefURL = "$ip/user/preference/";

  // user sign in
  Future<List<dynamic>> signIn(
      String userName, String password, CourseProvider course) async {
    final Map<String, dynamic> loginData = {
      "username": userName,
      "password": password,
    };
    _status = Status.Authentcating;
    notifyListeners();
    try {
      // login response
      final response = await http.post(loginURL,
          body: json.encode(loginData),
          headers: {'Content-Type': 'application/json'});
      // if we got good response
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var data = json.decode(response.body);
        await FlutterSession().set("tokenKey", data['key']);
        final resp = await http.get(userURL, headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ${data["key"]}'
        });
        print("user");
        print(resp.body);
        var data1 = json.decode(resp.body) as List;
        _userModel = UserModel.fromJson(data1[0]);
        await FlutterSession().set("userName", userModel.username);
        // await FlutterSession().set("lastName", userModel.lastName);
        // await FlutterSession().set("firstName", userModel.firstName);
        await FlutterSession().set("email", userModel.email);
        await FlutterSession().set("userID", userModel.userID);
        await course.getCourse();
        _status = Status.Authenticated;
        return [true];
      }
      // if we got bad requests
      else if (response.statusCode == 400) {
        _status = Status.Unauthenticated;
        notifyListeners();
        return [false, json.decode(response.body)];
      }
      // any other server response
      else {
        return [false];
      }
    }
    // if connection is not formed
    catch (e) {
      _status = Status.Failed;
      notifyListeners();
      return [false];
    }
  }

// url registration
  Future<List<dynamic>> signUp(String username, String email, String password,
      String firstName, String lastName) async {
    Map<String, dynamic> registerData = {
      "first_name": firstName,
      "last_name": lastName,
      "username": username,
      "email": email,
      "password1": password,
      "password2": password
    };
    _status = Status.Authentcating;
    notifyListeners();
    try {
      // response from registeration
      final response = await http
          .post(registerURL, body: json.encode(registerData), headers: {
        'Content-Type': 'application/json',
      });
      // if we got good response
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        _status = Status.Authenticated;
        notifyListeners();
        return [true];
      }
      // if we got bad requests
      else if (response.statusCode == 400) {
        _status = Status.Unauthenticated;
        notifyListeners();
        return [false, json.decode(response.body)];
      }
      // any other responses occur
      else {
        return [false];
      }
    }
    // if connection is not formed
    catch (e) {
      _status = Status.Failed;
      notifyListeners();
      return [false];
    }
  }

  sessionCheck(CourseProvider courseProvider) async {
    if (screen == null) {
      if (await FlutterSession().get('tokenKey') == "" ||
          await FlutterSession().get('tokenKey') == null) {
        _screen = HomeScreen();
        notifyListeners();
        return;
      } else {
        _screen = ProfileScreen();
        notifyListeners();
        return;
      }
    } else {
      return;
    }
  }

  Future<List<dynamic>> preferenceInput(String username, String email,
      String password, String selectedButton) async {
    var tokenKey = await FlutterSession().get('tokenKey');
    Map<String, dynamic> preferenceData = {
      "accountType": "Silver Account",
      "siteLang": "English"
    };
    print(preferenceData);
    _status = Status.Authentcating;
    notifyListeners();
    try {
      // response from registeration
      // final response = await http.post(prefURL,
      //     body: json.encode(preferenceData),
      //     headers: {
      //       'Content-Type': 'application/json',
      //       'Authorization': 'Token $tokenKey'
      // });
      final response = await http.get(prefURL, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $tokenKey'
      });
      // if we got good response
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        _status = Status.Authenticated;
        notifyListeners();
        return [true];
      }
      // if we got bad requests
      else if (response.statusCode == 400) {
        _status = Status.Unauthenticated;
        notifyListeners();
        return [false, json.decode(response.body)];
      }
      // any other responses occur
      else {
        return [false];
      }
    }
    // if connection is not formed
    catch (e) {
      _status = Status.Failed;
      notifyListeners();
      return [false];
    }
  }

  signOut() async {
    await FlutterSession().set("tokenKey", "");
    await FlutterSession().set("userModel", "");
  }
}
