class UserModel {
  // key for the map value
  static const USERNAME = "username";
  static const EMAIL = "email";
  static const FIRST_NAME = "firstName";
  static const LAST_NAME = "lastName";
  static const STUDENT = "student";
  static const USER_ID = "id";

  // Objects the class instantiate
  String _username;
  String _email;
  String _firstName;
  String _lastName;
  int _userID;

  // getter
  String get username => _username;
  String get email => _email;
  String get firstName => _firstName;
  String get lastName => _lastName;
  int get userID => _userID;

  // To create object from the given map value.
  UserModel.fromJson(json) {
    _username = json[STUDENT][USERNAME];
    _email = json[STUDENT][EMAIL];
    _firstName = json[FIRST_NAME];
    _lastName = json[LAST_NAME];
    _userID = json[USER_ID];
  }
}
