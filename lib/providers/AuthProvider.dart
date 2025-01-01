import 'dart:convert';

import 'package:fe_giotmauvang_mobile/services/AuthService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;
  String? _token;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get token => _token;
  Map<String, dynamic>? _userData;
  Future<void> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _authService.login(username, password);

      if (response['code'] == 200) {
        // Lưu token và thông tin người dùng vào SecureStorage
        _token = response['token'];
        _userData = response['user'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);

        await saveUserData(response['user']);
        _isAuthenticated = true;
      } else {
        _error = response['message'];
        _isAuthenticated = false;
      }
    } catch (e) {
      _error = e.toString();
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      String jsonString = jsonEncode(userData);  // Chuyển Map thành chuỗi JSON
      await _secureStorage.write(key: 'user_data', value: jsonString);
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  // Truy xuất thông tin người dùng từ SecureStorage và chuyển đổi lại thành Map
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      String? jsonString = await _secureStorage.read(key: 'user_data');
      if (jsonString != null) {
        return jsonDecode(jsonString);  // Chuyển chuỗi JSON trở lại thành Map
      }
    } catch (e) {
      print('Error reading user data: $e');
    }
    return null;
  }


  // Đăng xuất
  Future<void> logout() async {
    await _secureStorage.delete(key: 'jwt_token');
    await _secureStorage.delete(key: 'user_data');

    _token = null;
    _userData = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  // Kiểm tra xem người dùng đã đăng nhập hay chưa
  Future<void> checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    // Kiểm tra token còn không
    if (token != null && token.isNotEmpty) {
      // Giả sử kiểm tra token hợp lệ (có thể là gọi API kiểm tra token)
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }
    notifyListeners();
  }
}