import 'package:flutter/cupertino.dart';

import '../models/User.dart';
import '../models/UserInfo.dart';
import '../services/UserService.dart';

class RegisterProvider with ChangeNotifier {
  final UserService _userService = UserService();
  
  User? _userData;
  UserInfo? _userInfo;
  bool _isLoading = false;
  String? _error;

  User? get userData => _userData;
  UserInfo? get userInfo => _userInfo;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> submitUserData(User user) async {
    try {
      _isLoading = true;
      notifyListeners();
      _userData = user;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> submitUserInfo(UserInfo info) async {
    try {
      _isLoading = true;
      notifyListeners();
      _userInfo = info;

      final completeUser = User(
        cccd: _userData!.cccd,
        password: _userData!.password,
        phone: _userData!.phone,
        email: _userData!.email,
        userInfo: _userInfo,
        roleId: 2,
      );

      final response = await _userService.register(completeUser);

      if (response.success) {
        return true;
      } else {
        _error = response.message;
        return false;
      }

    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}