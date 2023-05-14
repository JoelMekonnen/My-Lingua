class ContentModel {
  // key for the map value
  static const CONTENT_ID = "id";
  static const CONTENT_VALUE = "contentValue";
  static const CONTENT_IMAGE = "contentImage";
  static const CONTENT_AUDIO = "contentAudio";
  static const CONTENT_VIDEO = "contentVideo";
  static const IS_COMPLETED = "isComplete";
  static const CREATED_BY = "createdBy";
  static const CONTENT_TITLE = "contentTitle";
  static const COURSE_ID = "courseId";
  static const CONTENT_LEVEL = "contentLevel";
  static const SELF_ID = "selfID";

  // Objects the class instantiate
  int _contentID;
  String _contentValue;
  String _contentImage;
  String _contentAudio;
  String _contentVideo;
  bool _isCompleted;
  int _createdBy;
  String _contentTitle;
  int _courseID;
  int _contentLevel;
  int _selfID;

  // getter
  int get contentID => _contentID;
  String get contentImage => _contentImage;
  String get contentValue => _contentValue;
  String get contentAudio => _contentAudio;
  String get contentVideo => _contentVideo;
  bool get isCompleted => _isCompleted;
  int get createdBy => _createdBy;
  String get contentTitle => _contentTitle;
  int get courseID => _courseID;
  int get contentLevel => _contentLevel;
  int get selfId => _selfID;

  // To create object from the given map value.
  ContentModel.fromJson(json) {
    _contentID = json[CONTENT_ID];
    _contentValue = json[CONTENT_VALUE];
    _contentImage = json[CONTENT_IMAGE];
    _contentAudio = json[CONTENT_AUDIO];
    _contentVideo = json[CONTENT_VIDEO];
    _isCompleted = json[IS_COMPLETED];
    _createdBy = json[CREATED_BY];
    _contentTitle = json[CONTENT_TITLE];
    _courseID = json[COURSE_ID];
    _contentLevel = json[CONTENT_LEVEL];
    _selfID = json[SELF_ID];
  }
}
