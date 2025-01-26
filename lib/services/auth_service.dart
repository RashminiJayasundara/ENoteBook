import 'dart:convert';
import 'package:e_note_book/utils/auth_manger.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _loginUrl = 'http://10.0.2.2:8080/api/users/login';

  Future<http.Response> login(String userName, String password) async {
    final response = await http.post(Uri.parse(_loginUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': userName,
          'password': password,
        }));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      // Extract the token and userId
      final String token = responseBody['token'];
      final String userId = responseBody['userId'];

      // Store the token and userId
      await storeToken(token);
      await storeUserId(userId);
    } else {
      throw Exception(' Failed to login'); //[TODO alert]
    }
    return response;
  }
}
