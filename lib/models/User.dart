import 'package:fe_giotmauvang_mobile/models/UserInfo.dart';

class User {
  final String cccd;
  final String? email;
  final String? password;
  final String? phone;
  final int roleId;
  final UserInfo? userInfo;  // Changed from userInfoId

  User({
    required this.cccd,
    this.email,
    this.password,
    this.phone,
    required this.roleId,
    this.userInfo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      cccd: json['cccd'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      roleId: json['role_id'],
      userInfo: json['user_info'] != null
          ? UserInfo.fromJson(json['user_info'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cccd': cccd,
      'email': email,
      'password': password,
      'phone': phone,
      'role_id': roleId,
      'user_info': userInfo?.toJson(),
    };
  }
}