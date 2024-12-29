import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          // Hình ảnh banner
          Image.asset(
            'assets/banner.png',
            height: 320,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Phần tiêu đề
          Positioned(
            top: 104,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: 1024,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đặt lịch hẹn',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Hiến máu cứu người',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 570,
                    child: Text(
                      'Với mỗi lần hiến máu bạn có thể mang lại cơ hội cứu sống 3 người. Hãy cứu lấy mạng người bằng ít máu của mình!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Phần tìm kiếm
          Positioned(
            top: 305,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Thêm padding
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 20),
                          SizedBox(width: 5),
                          Text(
                            'Bạn cần đặt lịch vào thời gian nào?',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Từ ngày - Đến ngày',
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Nút tìm kiếm
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[100],
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            'Tìm kiếm',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Phần hướng dẫn
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Xem hướng dẫn quy trình đăng ký hiến máu >>> Tại đây',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[100],
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

