import 'package:shared_preferences/shared_preferences.dart';

//store token persistently on the deivice , it remains even after the app is closed
Future<void> storeToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("auth_token", token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("auth_token");
}

Future<void> storeUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("user_id", userId);
}

Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("user_id");
}
