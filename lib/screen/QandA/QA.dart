import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/footer_widget.dart';

class QAScreen extends StatefulWidget {
  const QAScreen({Key? key}) : super(key: key);

  @override
  _AccordionScreenState createState() => _AccordionScreenState();
}

class _AccordionScreenState extends State<QAScreen> {
  final List<bool> _isExpanded = List.generate(7, (_) => false);

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
                children: [
                  const Text(
                    'Lưu ý quan trọng',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildAccordionItem(
                    index: 0,
                    title: "1. Ai có thể tham gia hiến máu?",
                    content: [
                      "- Tất cả mọi người từ 18 - 60 tuổi, thực sự tình nguyện hiến máu của mình để cứu chữa người bệnh.",
                      "- Cân nặng ít nhất là 45kg đối với phụ nữ, nam giới. Lượng máu hiến mỗi lần không quá 9ml/kg cân nặng và không quá 500ml mỗi lần.",
                      "- Không bị nhiễm hoặc không có các hành vi lây nhiễm HIV và các bệnh lây nhiễm qua đường truyền máu khác.",
                      "- Thời gian giữa 2 lần hiến máu là 12 tuần đối với cả Nam và Nữ.",
                      "- Có giấy tờ tùy thân.",
                    ],
                  ),
                  _buildAccordionItem(
                    index: 1,
                    title: "2. Ai là người không nên hiến máu?",
                    content: [
                      "- Người đã nhiễm hoặc đã thực hiện hành vi có nguy cơ nhiễm HIV, viêm gan B, viêm gan C, và các virus lây qua đường truyền máu.",
                      "- Người có các bệnh mãn tính: tim mạch, huyết áp, hô hấp, dạ dày…",
                    ],
                  ),
                  _buildAccordionItem(
                    index: 2,
                    title: "3. Máu của tôi sẽ được làm những xét nghiệm gì?",
                    content: [
                      "- Tất cả những đơn vị máu thu được sẽ được kiểm tra nhóm máu (hệ ABO, hệ Rh), HIV, virus viêm gan B, virus viêm gan C, giang mai, sốt rét.",
                      "- Bạn sẽ được thông báo kết quả, được giữ kín và được tư vấn (miễn phí) khi phát hiện ra các bệnh nhiễm trùng nói trên.",
                    ],
                  ),
                  _buildAccordionItem(
                    index: 3,
                    title: "4. Máu gồm những thành phần và chức năng gì?",
                    content: [
                      "- Hồng cầu làm nhiệm vụ chính là vận chuyển oxy.",
                      "- Bạch cầu làm nhiệm vụ bảo vệ cơ thể.",
                      "- Tiểu cầu tham gia vào quá trình đông cầm máu.",
                      "- Huyết tương: gồm nhiều thành phần khác nhau: kháng thể, các yếu tố đông máu, các chất dinh dưỡng...",
                    ],
                  ),
                  _buildAccordionItem(
                    index: 4,
                    title: "5. Tại sao lại có nhiều người cần phải được truyền máu?",
                    content: [
                      "- Bị mất máu do chấn thương, tai nạn, thảm hoạ, xuất huyết tiêu hoá...",
                      "- Do bị các bệnh gây thiếu máu, chảy máu: ung thư máu, suy tuỷ xương, máu khó đông...",
                      "- Các phương pháp điều trị hiện đại cần truyền nhiều máu: phẫu thuật tim mạch, ghép tạng...",
                    ],
                  ),
                  _buildAccordionItem(
                    index: 5,
                    title: "6. Nhu cầu máu điều trị ở nước ta hiện nay?",
                    content: [
                      "- Mỗi năm nước ta cần khoảng 1.800.000 đơn vị máu điều trị.",
                      "- Máu cần cho điều trị hằng ngày, cho cấp cứu, cho dự phòng các thảm họa, tai nạn cần truyền máu với số lượng lớn.",
                      "- Hiện tại chúng ta đã đáp ứng được khoảng 54% nhu cầu máu cho điều trị.",
                    ],
                  ),
                  _buildAccordionItem(
                    index: 6,
                    title: "7. Tại sao khi tham gia hiến máu lại cần phải có giấy CMND?",
                    content: [
                      "- Mỗi đơn vị máu đều phải có hồ sơ, trong đó có các thông tin về người hiến máu. Đây là một thủ tục cần thiết trong quy trình hiến máu để đảm bảo tính xác thực thông tin về người hiến máu.",
                    ],
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

  Widget _buildAccordionItem({
    required int index,
    required String title,
    required List<String> content,
  }) {
    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded[index] = !_isExpanded[index];
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 187, 215, 253),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    _isExpanded[index]
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isExpanded[index])
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content.map((item) => Text(item)).toList(),
            ),
          ),
        const SizedBox(height: 16), // Space between items
      ],
    );
  }
}
