import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  SharedPreferences _preferences;
  static final Preferences instance = Preferences._instance();
  static const String username = 'USER_NAME';
  static const String id = 'ID';
  static const String email = 'EMAIL';
  static const String photoUrl = 'PHOTO_URL';
  static const String darkMode = 'DARK_MODE';
  static const String accessToken = 'ACCESS_TOKEN';

  Preferences._instance();

  Future<SharedPreferences> initPref() async {
    if (_preferences == null) {
      _preferences = await _initSharedPreferences();
    }
    return _preferences;
  }

  Future<SharedPreferences> _initSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  Future<bool> setUserId(String value) async {
    bool isSet = await _preferences.setString(id, value);
    return isSet;
  }

  Future<bool> setUserName(String value) async {
    bool isSet = await _preferences.setString(username, value);
    return isSet;
  }

  Future<bool> setUserEmail(String value) async {
    bool isSet = await _preferences.setString(email, value);
    return isSet;
  }

  Future<bool> setUserPhotoUrl(String value) async {
    bool isSet = await _preferences.setString(photoUrl, value);
    return isSet;
  }

  Future<bool> setAccessTken(String value) async {
    bool isSet = await _preferences.setString(accessToken, value);
    return isSet;
  }

  Future<bool> setDarkMode(bool value) async {
    bool isSet = await _preferences.setBool(darkMode, value);
    return isSet;
  }

  Future<bool> clearUser() async {
    bool isCleared = await _preferences.clear();
    return isCleared;
  }

  bool isFirstTime() => getUserId == '';

  String get getUserId => _preferences.getString(id) ?? '';

  String get getAccessToken => _preferences.getString(accessToken) ?? '';

  bool get getDarkMode => _preferences?.getBool(darkMode) ?? false;

  String get getUserName => _preferences.getString(username) ?? '';

  String get getUserEmail => _preferences.getString(email) ?? '';

  String get getUserPhotoUrl => _preferences.getString(photoUrl) ?? '';
}
