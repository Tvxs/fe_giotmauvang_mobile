import 'package:flutter/material.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({Key? key}) : super(key: key);

  @override
  _NotesWidgetState createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  List<bool> _expandedStates = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0), // Thêm padding ngoài
      child: Center(
        child: SizedBox(
          width: double.infinity, // Giới hạn độ rộng toàn bộ widget
          child: Column(
            children: [
              const Text(
                'Lưu ý quan trọng',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A), // blue-900
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              _buildExpandableNote(
                index: 0,
                title: 'Ai có thể tham gia hiến máu?',
                content: '''
                  - Tất cả mọi người từ 18 - 60 tuổi, thực sự tình nguyện hiến máu của mình để cứu chữa người bệnh.
                  - Cân nặng ít nhất là 45kg đối với phụ nữ, nam giới.
                  - Không bị nhiễm hoặc không có các hành vi lây nhiễm HIV.
                  - Thời gian giữa 2 lần hiến máu là 12 tuần đối với cả Nam và Nữ.
                  - Có giấy tờ tùy thân.
                ''',
              ),
              const SizedBox(height: 15),
              _buildExpandableNote(
                index: 1,
                title: 'Ai là người không nên hiến máu?',
                content: '''
                  - Người đã nhiễm hoặc đã thực hiện hành vi có nguy cơ nhiễm HIV, viêm gan B, viêm gan C.
                  - Người có các bệnh mãn tính: tim mạch, huyết áp, hô hấp, dạ dày…
                ''',
              ),
              const SizedBox(height: 15),
              _buildExpandableNote(
                index: 2,
                title: 'Máu của tôi sẽ được làm những xét nghiệm gì?',
                content: '''
                  - Tất cả những đơn vị máu thu được sẽ được kiểm tra nhóm máu, HIV, virus viêm gan B, virus viêm gan C, giang mai, sốt rét.
                  - Bạn sẽ được thông báo kết quả, được giữ kín và được tư vấn (miễn phí) khi phát hiện ra các bệnh nhiễm trùng nói trên.
                ''',
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Xem thêm > >',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableNote({
    required int index,
    required String title,
    required String content,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFBBD7FD)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF60A5FA), // blue-400
          ),
        ),
        trailing: Icon(
          _expandedStates[index] ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: const Color(0xFF60A5FA),
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _expandedStates[index] = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
