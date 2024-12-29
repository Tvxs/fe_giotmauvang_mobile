import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart'; // Đường dẫn tới file navbar.dart

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56), // Chiều cao của AppBar
        child: NavBarCustom(), // Sử dụng widget Navbar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/news_image.png', // Thay bằng đường dẫn hình ảnh của bạn
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Tiêu đề bài viết
            const Text(
              "CHƯƠNG TRÌNH LỄ KỶ NIỆM 30 NĂM XÂY DỰNG VÀ PHÁT TRIỂN "
                  "PHONG TRÀO HIẾN MÁU TÌNH NGUYỆN THÀNH PHỐ HỒ CHÍ MINH "
                  "GIAI ĐOẠN (1994-2024)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            // Nội dung mô tả
            const Text(
              "Sáng 22/11, Ban chỉ đạo vận động hiến máu tình nguyện TPHCM tổ chức "
                  "họp mặt kỷ niệm 30 năm xây dựng và phát triển phong trào hiến máu tình "
                  "nguyện TPHCM (1994-2024).",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
