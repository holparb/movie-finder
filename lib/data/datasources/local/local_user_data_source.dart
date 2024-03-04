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

  Future<String?> readSessionId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final sessionId = prefs.getString("sessionId");
    return (sessionId != null && sessionId.isNotEmpty) ? sessionId : null;
  }
}