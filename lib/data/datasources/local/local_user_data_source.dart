import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_finder/data/models/user_model.dart';
import 'package:movie_finder/core/constants.dart' as constants;

class LocalUserDataSource {

  const LocalUserDataSource();

  Future<void> writeUserData(String sessionId, UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(constants.sessionId, sessionId);
    await prefs.setInt(constants.userId, user.id);
    await prefs.setString(constants.username, user.username);
    return;
  }

  Future<void> deleteUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(constants.sessionId);
    await prefs.remove(constants.userId);
    await prefs.remove(constants.username);
    return;
  }

  Future<String?> _readString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final stringValue = prefs.getString(key);
    return (stringValue != null && stringValue.isNotEmpty) ? stringValue : null;
  }

  Future<String?> readSessionId() async {
    return await _readString(constants.sessionId);
  }

  Future<String?> readUsername() async {
    return await _readString(constants.username);
  }
}