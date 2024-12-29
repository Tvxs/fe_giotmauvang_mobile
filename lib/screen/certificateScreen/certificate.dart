import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/footer_widget.dart';
import 'dart:ui';

class CertificateScreen extends StatelessWidget {
  const CertificateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(106),
        child: NavBarCustom(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    'assets/chungNhan.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // Blur overlay
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.blueAccent.withOpacity(0.2),
                    ),
                  ),
                ),
                // Content
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Thêm giấy chứng nhận hiến máu của bạn tại đây. Nếu bạn chưa từng đặt lịch hiến trên hệ thống, hãy nhớ cập nhật thông tin cá nhân trước khi thực hiện thao tác này để quản trị có thể đối chiếu thông tin.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18, // Adjust font size
                              height: 1.5, // Line height
                            ),
                          ),
                          const SizedBox(height: 24), // Spacing between text and button
                          ElevatedButton(
                            onPressed: () {
                              // Add functionality here
                              print("Thêm chứng nhận button pressed!");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue, // Text color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              shadowColor: Colors.black.withOpacity(0.25),
                              elevation: 8,
                            ),
                            child: const Text(
                              'Thêm chứng nhận',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Footer
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
