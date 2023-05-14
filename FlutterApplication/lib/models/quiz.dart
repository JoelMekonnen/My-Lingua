class QuizModel {
  // key for the map value
  static const QUIZ_ID = "quizID";
  static const MARKS = "marks";
  static const QUIZ_DIR = "quizDir";
  static const ANS_DIR = "ansDir";
  static const SCORED = "scored";

  // Objects the class instantiate
  String _quizID;
  String _marks;
  String _quizDir;
  String _ansDir;
  String _scored;

  // getter
  String get quizID => _quizID;
  String get quizDir => _quizDir;
  String get marks => _marks;
  String get ansDir => _ansDir;
  String get scored => _scored;

  // To create object from the given map value.
  QuizModel.fromJson(json) {
    _quizID = json[QUIZ_ID];
    _marks = json[MARKS];
    _quizDir = json[QUIZ_DIR];
    _ansDir = json[ANS_DIR];
    _scored = json[SCORED];
  }
}
