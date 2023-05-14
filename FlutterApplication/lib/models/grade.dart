class GradeModel {
  // key for the map value
  static const GRADE_ID = "gradeID";
  static const GRADE_RES = "gradeRes";

  // Objects the class instantiate
  String _gradeID;
  String _gradeRes;

  // getter
  String get gradeID => _gradeID;
  String get gradeRes => _gradeRes;

  // To create object from the given map value.
  GradeModel.fromJson(json) {
    _gradeID = json[GRADE_ID];
    _gradeRes = json[GRADE_RES];
  }
}
