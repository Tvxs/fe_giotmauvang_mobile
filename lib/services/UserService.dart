import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fe_giotmauvang_mobile/services/AuthService.dart';

import '../models/DTO/ApiResponse.dart';
import '../models/User.dart';

class UserService {
  static const String baseUrl = 'http://192.168.72.1:8080';
  final AuthService _authService = AuthService();

  //get Profile
  Future<Map<String, dynamic>> getProfile() async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/adminuser/get-profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return _handleResponse(response);
  }


  // update User
  Future<Map<String, dynamic>> updateUser(String cccd, Map<String, String> userData) async {
    final token = await _authService.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/admin/update/$cccd'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(userData),
    );
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }
    throw Exception('Request failed: ${response.statusCode}');
  }


  Future<ApiResponse> register(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'cccd': user.cccd,
        'password': user.password,
        'phone': user.phone,
        'email': user.email,
        'fullName': user.userInfo?.fullName,
        'dob': user.userInfo?.dob?.toString(),
        'sex': user.userInfo?.sex,
        'address': user.userInfo?.address,
      }),
    );

    final data = jsonDecode(response.body);
    return ApiResponse.fromJson(data);
  }
}
