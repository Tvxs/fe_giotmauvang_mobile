import 'package:fe_giotmauvang_mobile/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(106),
        child: NavBarCustom(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nội dung chính
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/logo-hutech.png',
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
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
