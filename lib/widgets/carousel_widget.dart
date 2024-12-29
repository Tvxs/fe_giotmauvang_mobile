import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;
  final List<Map<String, String>> _slides = [
    {
      'title': 'Được bồi dưỡng trực tiếp',
      'content':
      '- Ăn nhẹ, nước uống tại chỗ: tương đương 30.000 đồng\n- Hỗ trợ chi phí đi lại: 50.000 đồng\n- Nhận phần quà tặng giá trị tương đương',
    },
    {
      'title': 'Được cấp Giấy chứng nhận hiến máu tình nguyện',
      'content':
      '1. Giấy chứng nhận được trao sau mỗi lần hiến máu\n2. Có giá trị để được truyền máu miễn phí...',
    },
    {
      'title': 'Được tư vấn về sức khoẻ',
      'content':
      '- Được giải thích về quy trình hiến máu\n- Được cung cấp thông tin về các dấu hiệu bệnh...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Thêm padding cho toàn bộ giao diện
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Phần tiêu đề và hình ảnh
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/carousel-left.png'), // Thay bằng hình của bạn
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Quyền lợi của người hiến máu',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Người hiến máu tình nguyện sẽ được những quyền lợi sau:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Phần nội dung bên dưới
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                    bottom: Radius.circular(20)
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemCount: _slides.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _slides[index]['title']!,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _slides[index]['content']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Nút điều hướng
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _slides.length,
                            (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? Colors.white
                                  : Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


