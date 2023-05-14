class InstructorModel {
  // key for the map value
  static const INST_ID = "instID";
  static const INST_NAME = "instName";
  static const INST_EMAIL = "instEmail";
  static const INST_PASS = "instPass";
  static const CONTENT_ID = "contentID";

  // Objects the class instantiate
  String _instID;
  String _instName;
  String _instEmail;
  String _instPass;
  String _contentID;

  // getter
  String get instID => _instID;
  String get instEmail => _instEmail;
  String get instName => _instName;
  String get instPass => _instPass;
  String get contentID => _contentID;

  // To create object from the given map value.
  InstructorModel.fromJson(json) {
    _instID = json[INST_ID];
    _instName = json[INST_NAME];
    _instEmail = json[INST_EMAIL];
    _instPass = json[INST_PASS];
    _contentID = json[CONTENT_ID];
  }
}
