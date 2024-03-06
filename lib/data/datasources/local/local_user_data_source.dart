import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_finder/data/models/user_model.dart';

class LocalUserDataSource {

  const LocalUserDataSource();

  Future<void> writeUserData(String sessionId, UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("sessionId", sessionId);
    await prefs.setInt("userId", user.id);
    await prefs.setString("userName", user.username);
    return;
  }

  Future<void> deleteUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("sessionId");
    await prefs.remove("userId");
    await prefs.remove("userName");
    return;
  }

  Future<String?> _readString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final stringValue = prefs.getString(key);
    return (stringValue != null && stringValue.isNotEmpty) ? stringValue : null;
  }

  Future<String?> readSessionId() async {
    return await _readString("sessionId");
  }

  Future<String?> readUsername() async {
    return await _readString("username");
  }
}