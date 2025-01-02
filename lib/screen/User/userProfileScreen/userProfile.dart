import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fe_giotmauvang_mobile/providers/AuthProvider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin người dùng'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Quay lại trang trước đó
          },
        ),
      ),
      body: FutureBuilder(
        future: context.read<AuthProvider>().getUserData(),  // Lấy dữ liệu người dùng từ AuthProvider
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Hiển thị loading khi dữ liệu chưa có
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Xử lý lỗi nếu có
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            // Trường hợp không có dữ liệu người dùng
            return const Center(child: Text('Không có dữ liệu người dùng'));
          } else {
            // Nếu có dữ liệu người dùng
            var userData = snapshot.data as Map<String, dynamic>;
            var userInfo = userData['userInfoDTO'];  // Lấy thông tin chi tiết người dùng từ DTO

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 100),
                  const SizedBox(height: 16),
                  Text('Tên: ${userInfo['fullName'] ?? 'Chưa cập nhật'}'),
                  Text('Ngày sinh: ${userInfo['dob'] ?? 'Chưa cập nhật'}'),
                  Text('Giới tính: ${userInfo['sex'] ?? 'Chưa cập nhật'}'),
                  Text('Địa chỉ: ${userInfo['address'] ?? 'Chưa cập nhật'}'),
                  const SizedBox(height: 16),
                  Text('Số điện thoại: ${userData['phone'] ?? 'Chưa cập nhật'}'),
                  Text('Email: ${userData['email'] ?? 'Chưa cập nhật'}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Thêm hành động nếu muốn, ví dụ như đổi mật khẩu, cập nhật thông tin,...
                    },
                    child: const Text('Cập nhật thông tin'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
