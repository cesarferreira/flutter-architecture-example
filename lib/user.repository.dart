import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  SharedPreferences prefs;

  UserRepository({this.prefs});

  static const String _IS_LOGGED_IN = "is_logged_in";
  static const String _NAME = "name";

  login(String name) async {
    await prefs.setBool(_IS_LOGGED_IN, true);
    await prefs.setString(_NAME, name);
  }

  Future<bool> isLoggedIn() async {
    return prefs.containsKey(_IS_LOGGED_IN);
  }

  Future<String> getName() async {
    return prefs.getString(_NAME);
  }

  logout() async {
    prefs.clear();
  }
}
