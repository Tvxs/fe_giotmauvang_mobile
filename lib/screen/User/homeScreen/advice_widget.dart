import 'package:flutter/material.dart';

class AdviceWidget extends StatelessWidget {
  const AdviceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF001F3F), // Màu var(--blue-dark)
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Những lời khuyên trước và sau khi hiến máu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFFFFD700), // var(--yellow)
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  _buildAdviceCard(
                    'assets/advice2.png',
                    'Nên:',
                    const Color(0xFF28A745), // var(--green)
                    [
                      'Ăn nhẹ và uống nhiều nước (300-500ml) trước khi hiến máu.',
                      'Đè chặt miếng bông gòn cầm máu nơi kim chích 10 phút...',
                      'Nằm và ngồi nghỉ tại chỗ 10 phút sau khi hiến máu.',
                      'Nằm nghỉ đầu thấp, kê chân cao nếu thấy chóng mặt...',
                      'Chườm lạnh vết chích nếu bị sưng, bầm tím.',
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildAdviceCard(
                    'assets/advice1.png',
                    'Không nên:',
                    const Color(0xFFFF0000), // var(--red)
                    [
                      'Uống sữa, rượu bia trước khi hiến máu.',
                      'Lái xe đi xa, khuân vác, làm việc nặng...',
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildAdviceCard(
                    'assets/advice3.png',
                    'Lưu ý:',
                    const Color(0xFFFFA500), // var(--orange)
                    [
                      'Nếu phát hiện chảy máu tại chỗ chích:',
                      'Giơ tay cao.',
                      'Lấy tay kia ấn nhẹ vào miếng bông hoặc băng dính.',
                      'Liên hệ nhân viên y tế để được hỗ trợ khi cần thiết.',
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdviceCard(String imagePath, String title, Color titleColor, List<String> content) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(imagePath, width: 60, height: 60),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...content.map(
                  (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '• $item',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
