class CourseModel {
  // key for the map value
  static const COURSENAME = "courseName";
  static const COURSE_ID = "id";
  static const COURSE_DESC = "courseDescription";
  static const CONTENT_ID = "contentID";
  static const COURSE_IMAGE = "courseImage";

  // Objects the class instantiate
  String _courseName;
  int _courseID;
  String _courseDesc;
  int _contentID;
  String _courseImage;
  bool selected;

  // getter
  String get courseName => _courseName;
  String get courseDesc => _courseDesc;
  int get courseID => _courseID;
  int get courseContent => _contentID;
  String get courseImage => _courseImage;

  // To create object from the given map value.
  CourseModel.fromJson(json) {
    _courseName = json[COURSENAME];
    _courseID = json[COURSE_ID];
    _courseDesc = json[COURSE_DESC];
    _contentID = json[CONTENT_ID];
    _courseImage = json[COURSE_IMAGE];
    selected = false;
  }

// Selection of course
  void select() {
    selected = true;
  }

// Deselection of course
  void deselect() {
    selected = false;
  }
}
