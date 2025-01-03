import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/EventProvider.dart';
import '../../providers/AppointmentProvider.dart';
import '../../providers/UserProvider.dart';
import '../../widgets/custom_app_bar.dart';

class BloodDonationBooking extends StatefulWidget {
  final String eventId;
  const BloodDonationBooking({Key? key, required this.eventId}) : super(key: key);

  @override
  State<BloodDonationBooking> createState() => _BloodDonationBookingState();
}

class _BloodDonationBookingState extends State<BloodDonationBooking> {
  int _currentStep = 0;
  late  Future<Map<String, dynamic>> _eventDataFuture;
  final BookingFormData _formData = BookingFormData();

  @override
  void initState() {
    super.initState();
    _eventDataFuture = _getEventData();
  }

  Future<Map<String, dynamic>> _getEventData() async {
    // Simulate API call
    return await   context.read<EventProvider>().getEventById(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(106),

        child: NavBarCustom(),

      ),
      body: Column(
        children: [
          _buildStepper(),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _eventDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text('No data available'));
                }
                return _buildMainContent(snapshot.data!);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          _buildStepItem(isActive: _currentStep >= 0, icon: Icons.calendar_today, label: 'Thời gian & địa điểm'),
          Expanded(
            child: Container(
              height: 2,
              color: _currentStep > 0 ? Colors.blue : Colors.grey[300],
            ),
          ),
          _buildStepItem(isActive: _currentStep >= 1, icon: Icons.description, label: 'Phiếu đăng ký'),
        ],
      ),
    );
  }

  Widget _buildStepItem({required bool isActive, required IconData icon, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.blue : Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(Map<String, dynamic> eventData) {
    return _currentStep == 0
        ? _buildTimeLocationStep(eventData)
        : _buildHealthQuestionnaire();
  }

  Widget _buildTimeLocationStep(Map<String, dynamic> eventData) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateSection(),
          const SizedBox(height: 24),
          _buildLocationSection(eventData),
          const SizedBox(height: 24),
          _buildBloodTypeSection(),
          const SizedBox(height: 24),
          _buildTimeSection(eventData),
          const SizedBox(height: 32),
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chọn ngày',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(_formData.selectedDate),
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection(Map<String, dynamic> eventData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.location_on, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              'Chọn địa điểm hiến máu',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildLocationDropdown('Tỉnh/Thành phố', 'Thành phố Hồ Chí Minh'),
        const SizedBox(height: 12),
        _buildLocationDropdown(
          'Địa điểm',
          eventData['donationUnitDTO']['location'],
          subtitle: eventData['address'],
        ),
      ],
    );
  }

  Widget _buildLocationDropdown(String label, String value, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBloodTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Nhóm máu cần hiến', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildBloodTypeChip('Nhóm máu A', Colors.cyan),
            _buildBloodTypeChip('Nhóm máu B', Colors.amber),
            _buildBloodTypeChip('Nhóm máu AB', Colors.red),
            _buildBloodTypeChip('Nhóm máu O', Colors.green),
          ],
        ),
      ],
    );
  }

  Widget _buildBloodTypeChip(String label, Color color) {
    return Chip(
      backgroundColor: color.withOpacity(0.2),
      label: Text(label),
    );
  }

  Widget _buildTimeSection(Map<String, dynamic> eventData) {
    String timeSlot = _formatTimeSlot(eventData['eventStartTime'], eventData['eventEndTime']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Chọn khung giờ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(timeSlot, style: const TextStyle(fontSize: 16)),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => setState(() => _currentStep = 1),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text('Tiếp tục'),
      ),
    );
  }

  Widget _buildHealthQuestionnaire() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Câu hỏi 1: Đã hiến máu chưa?
          _buildHealthQuestion(
            label: '1. Bạn đã hiến máu bao giờ chưa?',
            value: _formData.healthMetrics['hasDonatedBefore'],
            onChanged: (bool? value) {
              setState(() {
                _formData.healthMetrics['hasDonatedBefore'] = value!;
              });
            },
          ),

          // Câu hỏi 2: Có bệnh mãn tính không?
          _buildHealthQuestion(
            label: '2. Bạn có bệnh mãn tính không?',
            value: _formData.healthMetrics['hasChronicDiseases'],
            onChanged: (bool? value) {
              setState(() {
                _formData.healthMetrics['hasChronicDiseases'] = value!;
              });
            },
          ),

          // Câu hỏi 3: Có bệnh gần đây không?
          _buildHealthQuestion(
            label: '3. Bạn có bệnh gần đây không?',
            value: _formData.healthMetrics['hasRecentDiseases'],
            onChanged: (bool? value) {
              setState(() {
                _formData.healthMetrics['hasRecentDiseases'] = value!;
              });
            },
          ),

          // Câu hỏi 4: Có triệu chứng không?
          _buildHealthQuestion(
            label: '4. Bạn có triệu chứng bệnh gần đây không?',
            value: _formData.healthMetrics['hasSymptoms'],
            onChanged: (bool? value) {
              setState(() {
                _formData.healthMetrics['hasSymptoms'] = value!;
              });
            },
          ),

          // Câu hỏi 5: Bạn có đang mang thai hoặc cho con bú không?
          _buildHealthQuestion(
            label: '5. Bạn có đang mang thai hoặc cho con bú không?',
            value: _formData.healthMetrics['isPregnantOrNursing'],
            onChanged: (bool? value) {
              setState(() {
                _formData.healthMetrics['isPregnantOrNursing'] = value!;
              });
            },
          ),

          // Câu hỏi 6: Đồng ý xét nghiệm HIV?
          _buildHealthQuestion(
            label: '6. Bạn đồng ý xét nghiệm HIV không?',
            value: _formData.healthMetrics['HIVTestAgreement'],
            onChanged: (bool? value) {
              setState(() {
                _formData.healthMetrics['HIVTestAgreement'] = value!;
              });
            },
          ),

          // Nút gửi form
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Gửi Phiếu'),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthQuestion({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }

  Future<void> _submitForm() async {
    // if (!_validateAnswers()) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Bạn chưa đủ điều kiện để đăng ký.')),
    //   );
    //   return;
    // }

    try {
      // Lấy SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      // Lấy cccd từ SharedPreferences
      String? jsonString  = prefs.getString('user_data');
      if (jsonString != null) {
        // Giải mã chuỗi JSON thành Map
        Map<String, dynamic> userData = jsonDecode(jsonString);

        // Truy cập vào trường 'username' trong Map

        final appointmentProvider = context.read<AppointmentProvider>();

        final success = await appointmentProvider.saveAppointment(
          userData['username'], // Sử dụng cccd lấy từ SharedPreferences
          widget.eventId,
          _formData.healthMetrics,
        );
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đặt lịch thành công!')),
          );
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(appointmentProvider.errorMessage ?? 'Có lỗi xảy ra')),
          );
        }
      }


      // else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(appointmentProvider.error ?? 'Lỗi không xác định')),
      //   );
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // bool _validateAnswers() {
  //   // Đặt tiêu chuẩn cho các câu trả lời
  //   final Map<String, dynamic> healthMetrics = {
  //     'hasDonatedBlood': false,
  //     'hasChronicDiseases': false,
  //     'hasRecentDiseases': false,
  //     'hasSymptoms': false,
  //     'isPregnantOrNursing': false,
  //     'HIVTestAgreement': true,
  //   };
  //
  //   // Lặp qua từng mục trong healthMetrics và so sánh với _formData.healthMetrics
  //   for (var entry in healthMetrics.entries) {
  //     // Kiểm tra nếu câu trả lời của người dùng không hợp lệ
  //     if (!_formData.healthMetrics.containsKey(entry.key)) {
  //       print("Câu trả lời cho ${entry.key} bị thiếu.");
  //       return false; // Trả về false nếu câu trả lời không tồn tại
  //     }
  //
  //     // So sánh giá trị của câu trả lời trong _formData với giá trị tiêu chuẩn
  //     var userAnswer = _formData.healthMetrics[entry.key];
  //
  //     // Kiểm tra xem câu trả lời có hợp lệ với giá trị tiêu chuẩn không
  //     if (userAnswer == null || userAnswer == entry.value) {
  //       print("Câu trả lời cho ${entry.key} không hợp lệ.");
  //       return false; // Trả về false nếu có giá trị không hợp lệ
  //     }
  //   }
  //
  //   // Nếu tất cả câu trả lời hợp lệ
  //   print("Tất cả câu trả lời hợp lệ.");
  //   return true;
  // }

  String _formatTimeSlot(String? startTime, String? endTime) {
    if (startTime == null || endTime == null) return 'Chưa có thông tin';
    try {
      final start = DateFormat('HH:mm:ss').parse(startTime);
      final end = DateFormat('HH:mm:ss').parse(endTime);
      return '${DateFormat('HH:mm').format(start)} - ${DateFormat('HH:mm').format(end)}';
    } catch (e) {
      print('Error formatting time slot: $e');
      return 'Chưa có thông tin';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _formData.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _formData.selectedDate) {
      setState(() => _formData.selectedDate = picked);
    }
  }
}

class BookingFormData {
  DateTime selectedDate = DateTime.now();
  final Map<String, dynamic> healthMetrics = {
    'hasDonatedBefore': false,
    'hasChronicDiseases': false,
    'hasRecentDiseases': false,
    'hasSymptoms': false,
    'isPregnantOrNursing': false,
    'HIVTestAgreement': true,
  };
}