import 'package:fe_giotmauvang_mobile/services/AuthService.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;
  String? _token;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get token => _token;

  Future<bool> login(String username, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _authService.login(username, password);
      if (response['code'] == 200) {
        _isAuthenticated = true;
        _token = response['token'];
        notifyListeners();
        return true;
      }
      _error = response['message'];
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(Map<String, String> userData) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _authService.register(userData);
      if (response['code'] == 200) {
        return true;
      }
      _error = response['message'];
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}