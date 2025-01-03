import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/QAProvider.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/footer_widget.dart';

class QAScreen extends StatefulWidget {
  const QAScreen({super.key});

  @override
  State<QAScreen> createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  late List<bool> _isExpanded; // Khai báo biến _isExpanded

  @override
  void initState() {
    super.initState();
    // Lấy dữ liệu khi màn hình được mở
    Future.microtask(() {
      Provider.of<QAProvider>(context, listen: false).fetchQA();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(106),
        child: NavBarCustom(),
      ),
      body: Consumer<QAProvider>(
        builder: (context, qaProvider, child) {
          if (qaProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (qaProvider.errorMessage.isNotEmpty) {
            return Center(child: Text('Error: ${qaProvider.errorMessage}'));
          }

          // Cập nhật _isExpanded để có chiều dài giống faqDTOList
          _isExpanded = List.generate(qaProvider.faqList.length, (_) => false);

          return SingleChildScrollView(
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
                      // Duyệt qua danh sách câu hỏi và hiển thị chúng
                      ...List.generate(qaProvider.faqList.length, (index) {
                        var faqItem = qaProvider.faqList[index];
                        return _buildAccordionItem(
                          index: index,
                          title: faqItem['title'], // Lấy title từ dữ liệu
                          content: [faqItem['description']], // Lấy description từ dữ liệu
                        );
                      }),
                    ],
                  ),
                ),
                const FooterWidget(),
              ],
            ),
          );
        },
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
                  Expanded(child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Thêm phần này
                    maxLines: 1,
                  )),

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content.map((item) => Text(item)).toList(),
              ),
            ),
          ),
        const SizedBox(height: 16), // Space between items
      ],
    );
  }
}
