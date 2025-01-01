import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:8080/auth';
  final _prefs = SharedPreferences.getInstance();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    final data = _handleResponse(response);
    if (data['code'] == 200 && data['token'] != null) {
      final prefs = await _prefs;
      await prefs.setString('token', data['token']);
    }
    return data;
  }

  Future<Map<String, dynamic>> register(Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );
    return _handleResponse(response);
  }

  Future<String?> getToken() async {
    final prefs = await _prefs;
    return prefs.getString('token');
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }
    throw Exception('Request failed: ${response.statusCode}');
  }
}