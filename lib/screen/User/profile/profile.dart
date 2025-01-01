import 'package:flutter/material.dart';
import 'package:fe_giotmauvang_mobile/widgets/custom_app_bar.dart';
import 'package:fe_giotmauvang_mobile/widgets/footer_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(106),
        child: NavBarCustom(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    'Thông tin cá nhân',
                    [
                      _buildInfoRow('Số CMND', '352736016'),
                      _buildInfoRow('Họ và tên', 'Dương Nguyễn Chí Tín'),
                      _buildInfoRow('Ngày sinh', '09/05/2003'),
                      _buildInfoRow('Giới tính', 'Nam'),
                      _buildInfoRow('Nhóm máu', '-'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Thông tin liên hệ',
                    [
                      _buildInfoRow('Địa chỉ liên lạc',
                          '38 đường 904, Phường Hiệp Phú, Thành Phố Thủ Đức, Tp Hồ Chí Minh'),
                      _buildInfoRow('Điện thoại di động', '0706389781'),
                      _buildInfoRow('Điện thoại bàn', '-'),
                      _buildInfoRow('Email', 'chitin952003@gmail.com'),
                      _buildInfoRow('Nghề nghiệp', 'Sinh viên'),
                    ],
                    showEditButton: true,
                  ),
                ],
              ),
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children, {bool showEditButton = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            if (showEditButton)
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Chỉnh sửa'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}