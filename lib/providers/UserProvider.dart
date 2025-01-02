import 'package:fe_giotmauvang_mobile/services/UserService.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  Map<String, dynamic>? _userProfile;
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Map<String, dynamic>? _userData; // Lấy DTO USER
            ///// MỌI NGƯỜI VIẾT GÌ NHỚ COMMENT LẠI NHA _ TÍN

  Future<void> loadProfile() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _userService.getProfile();
      _userProfile = response['data'];
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateProfile(String cccd, Map<String, String> userData) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _userService.updateUser(cccd, userData);
      if (response['code'] == 200) {
        await loadProfile();
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