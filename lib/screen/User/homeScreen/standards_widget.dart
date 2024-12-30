import 'package:flutter/material.dart';

class StandardsWidget extends StatelessWidget {
  const StandardsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: 1024,
            child: Column(
              children: [
                _buildTopRow(),
                const SizedBox(height: 10),
                _buildMiddleRow(),
                const SizedBox(height: 10),
                _buildBottomRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStandardCard({
    required String icon,
    required String text,
    double height = 150,
    bool isLarge = false,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.credit_card, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
            maxLines: isLarge ? null : 3,
            overflow: isLarge ? null : TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: 284,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: const AssetImage('assets/standard1.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8),
                  BlendMode.softLight,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: Text(
                  'Tiêu chuẩn tham gia hiến máu',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              _buildStandardCard(
                icon: 'id_card',
                text: 'Mang theo chứng minh nhân dân/hộ chiếu',
                height: 170,
              ),
              const SizedBox(height: 10),
              _buildStandardCard(
                icon: 'warning',
                text: 'Không nghiện ma túy, rượu bia và các chất kích thích',
                height: 170,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStandardCard(
            icon: 'health',
            text: 'Không mắc hoặc không có các hành vi nguy cơ lây nhiễm HIV, không nhiễm viêm gan B, viêm gan C, và các virus lây qua đường truyền máu',
            height: 350,
            isLarge: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMiddleRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildStandardCard(
            icon: 'weight',
            text: 'Cân nặng: Nam ≥ 45 kg Nữ ≥ 45 kg',
            height: 170,

          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStandardCard(
            icon: 'heart',
            text: 'Không mắc các bệnh mãn tính hoặc cấp tính về tim mạch, huyết áp, hô hấp, dạ dày…',
            height: 170,

          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStandardCard(
            icon: 'lab',
            text: 'Chỉ số huyết sắc tố (Hb) ≥120g/l (≥125g/l nếu hiến từ 350ml trở lên).',
            height: 170,

          ),
        ),
      ],
    );
  }

  Widget _buildBottomRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildStandardCard(
            icon: 'person',
            text: 'Người khỏe mạnh trong độ tuổi từ đủ 18 đến 60 tuổi',
            height: 170,

          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStandardCard(
            icon: 'timer',
            text: 'Thời gian tối thiểu giữa 2 lần hiến máu là 12 tuần đối với cả Nam và Nữ',
            height: 170,

          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStandardCard(
            icon: 'test',
            text: 'Kết quả test nhanh âm tính với kháng nguyên bề mặt của siêu vi B',
            height: 170,

          ),
        ),
      ],
    );
  }
}
