class CertificateModel {
  // key for the map value
  static const CERT_ID = "certID";
  static const CERT_DATE = "certDate";
  static const CERT_URL = "certUrl";
  static const UID = "uID";
  static const COURSE_ID = "courseID";

  // Objects the class instantiate
  String _certID;
  String _certDate;
  String _certUrl;
  String _uID;
  String _courseID;

  // getter
  String get certID => _certID;
  String get certUrl => _certUrl;
  String get certDate => _certDate;
  String get uID => _uID;
  String get courseID => _courseID;

  // To create object from the given map value.
  CertificateModel.fromJson(json) {
    _certID = json[CERT_ID];
    _certDate = json[CERT_DATE];
    _certUrl = json[CERT_URL];
    _uID = json[UID];
    _courseID = json[COURSE_ID];
  }
}
