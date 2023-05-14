class PreferenceModel {
  // key for the map value
  static const PREF_ID = "prefID";
  static const SITE_LANG = "siteLang";
  static const START_LEVEL = "startLevel";
  static const CURR_LEVEL = "currLevel";
  static const ACCOUNT_TYPE = "accountType";

  // Objects the class instantiate
  String _prefID;
  String _siteLang;
  String _startLevel;
  String _currLevel;
  String _accountType;

  // getter
  String get prefID => _prefID;
  String get startLevel => _startLevel;
  String get siteLang => _siteLang;
  String get currLevel => _currLevel;
  String get accountType => _accountType;

  // To create object from the given map value.
  PreferenceModel.fromJson(json) {
    _prefID = json[PREF_ID];
    _siteLang = json[SITE_LANG];
    _startLevel = json[START_LEVEL];
    _currLevel = json[CURR_LEVEL];
    _accountType = json[ACCOUNT_TYPE];
  }
}
