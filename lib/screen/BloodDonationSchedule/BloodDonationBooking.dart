// import 'package:fe_giotmauvang_mobile/providers/AppointmentProvider.dart';
// import 'package:fe_giotmauvang_mobile/providers/UserProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// class BloodDonationBooking extends StatefulWidget {
//   const BloodDonationBooking({Key? key}) : super(key: key);
//
//   @override
//   State<BloodDonationBooking> createState() => _BloodDonationBookingState();
// }
//
// class _BloodDonationBookingState extends State<BloodDonationBooking> {
//   int _currentStep = 0;
//   DateTime selectedDate = DateTime.now();
//   final timeSlot = "07:00 - 11:00";
//   Map<String, bool> answers = {};
//   Map<String, dynamic> healthMetrics = {};
//
//   final Map<String, TextEditingController> otherControllers = {
//     '2.3': TextEditingController(),
//     '3.5': TextEditingController(),
//     '4.9': TextEditingController(),
//     '5.5': TextEditingController(),
//     '6.5': TextEditingController(),
//   };
//
//   void _updateHealthMetrics() {
//     healthMetrics = {
//       'hasDonatedBlood': answers['1.1'] ?? false,
//       'hasChronicDiseases': answers['2.1'] ?? false,
//       'chronicDiseaseDetails': otherControllers['2.3']?.text,
//       'hasRecentDiseases':
//           ['3.1', '3.2', '3.3'].any((key) => answers[key] ?? false),
//       'recentDiseaseDetails': otherControllers['3.5']?.text,
//       'hasSymptoms': ['4.1', '4.2', '4.3', '4.4', '4.5', '4.6', '4.7']
//           .any((key) => answers[key] ?? false),
//       'symptomDetails': otherControllers['4.9']?.text,
//       'hasRecentConditions':
//           ['5.1', '5.2', '5.3'].any((key) => answers[key] ?? false),
//       'recentConditionDetails': otherControllers['5.5']?.text,
//       'hasRecentMedicationsOrVaccines':
//           ['6.1', '6.2', '6.3'].any((key) => answers[key] ?? false),
//       'recentMedicationDetails': otherControllers['6.5']?.text,
//       'isPregnantOrNursing': answers['7.1'] ?? false,
//       'hasMenstrualCycle': answers['7.2'] ?? false,
//       'HIVTestAgreement': answers['8.1'] ?? true,
//       'additionalNotes': {
//         'chronicDetails': otherControllers['2.3']?.text,
//         'recentDiseases': otherControllers['3.5']?.text,
//         'symptoms': otherControllers['4.9']?.text,
//         'otherConditions': otherControllers['5.5']?.text,
//         'recentMedications': otherControllers['6.5']?.text,
//       },
//     };
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 30)),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           _buildHeader(),
//           _buildStepper(),
//           Expanded(
//             child: SingleChildScrollView(
//               child: _currentStep == 0
//                   ? _buildTimeLocationStep()
//                   : _buildRegistrationStep(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: const Text(
//         'Đặt lịch hiến máu',
//         style: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStepper() {
//     return Row(
//       children: [
//         _buildStepItem(
//             isActive: _currentStep >= 0,
//             icon: Icons.calendar_today,
//             label: 'Thời gian & địa điểm'),
//         Expanded(
//           child: Container(
//               height: 2,
//               color: _currentStep > 0 ? Colors.blue : Colors.grey[300]),
//         ),
//         _buildStepItem(
//             isActive: _currentStep >= 1,
//             icon: Icons.description,
//             label: 'Phiếu đăng ký'),
//       ],
//     );
//   }
//
//   Widget _buildStepItem(
//       {required bool isActive, required IconData icon, required String label}) {
//     return Column(
//       children: [
//         Icon(icon, color: isActive ? Colors.blue : Colors.grey),
//         const SizedBox(height: 4),
//         Text(label,
//             style: TextStyle(color: isActive ? Colors.blue : Colors.grey)),
//       ],
//     );
//   }
//
//   Widget _buildTimeLocationStep() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildDateSelection(),
//           const SizedBox(height: 24),
//           _buildLocationSelection(),
//           const SizedBox(height: 24),
//           _buildBloodTypeNeeded(),
//           const SizedBox(height: 24),
//           _buildTimeSlots(),
//           const SizedBox(height: 32),
//           _buildContinueButton(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDateSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Chọn ngày',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         InkWell(
//           onTap: () => _selectDate(context),
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey[300]!),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   DateFormat('dd/MM/yyyy').format(selectedDate),
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const Icon(Icons.calendar_today),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLocationSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: const [
//             Icon(Icons.location_on, color: Colors.blue),
//             SizedBox(width: 8),
//             Text(
//               'Chọn địa điểm hiến máu',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         _buildLocationDropdown('Tỉnh/Thành phố', 'Hồ Chí Minh'),
//         const SizedBox(height: 12),
//         _buildLocationDropdown(
//           'Địa điểm',
//           'Hiến máu - 466 Nguyễn Thị minh Khai',
//           subtitle:
//               '466 Nguyễn Thị Minh Khai Phường 02, Quận 3, Tp Hồ Chí Minh',
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLocationDropdown(String label, String value,
//       {String? subtitle}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         const SizedBox(height: 4),
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey[300]!),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(value,
//                         style: const TextStyle(fontWeight: FontWeight.bold)),
//                     if (subtitle != null)
//                       Text(
//                         subtitle,
//                         style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                       ),
//                   ],
//                 ),
//               ),
//               const Icon(Icons.arrow_drop_down),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBloodTypeNeeded() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Nhóm máu cần hiến',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           children: [
//             _buildBloodTypeChip('Nhóm máu A', Colors.cyan),
//             _buildBloodTypeChip('Nhóm máu B', Colors.amber),
//             _buildBloodTypeChip('Nhóm máu AB', Colors.red),
//             _buildBloodTypeChip('Nhóm máu O', Colors.green),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBloodTypeChip(String label, Color color) {
//     return Chip(
//       label: Text(
//         label,
//         style: const TextStyle(color: Colors.white),
//       ),
//       backgroundColor: color,
//     );
//   }
//
//   Widget _buildTimeSlots() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: const [
//             Icon(Icons.access_time, color: Colors.blue),
//             SizedBox(width: 8),
//             Text(
//               'Chọn khung giờ bạn sẽ đến hiến máu',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey[300]!),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Thời gian nhận hồ sơ',
//                 style: TextStyle(color: Colors.grey[600]),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   timeSlot,
//                   style: const TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContinueButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           setState(() {
//             _currentStep = 1;
//           });
//         },
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(vertical: 16),
//         ),
//         child: const Text('Tiếp tục'),
//       ),
//     );
//   }
//
//   // Widget _buildContinueButton() {
//   //   return ElevatedButton(
//   //     onPressed: () {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => RegistrationForm(
//   //             selectedDate: selectedDate,
//   //             timeSlot: timeSlot,
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //     child: const Text('Tiếp tục'),
//   //   );
//   // }
//   @override
//   void dispose() {
//     for (var controller in otherControllers.values) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   Widget _buildQuestionCard(String title, List<QuestionOption> options) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             ...options.map((option) {
//               if (option.hasTextField) {
//                 return Column(
//                   children: [
//                     CheckboxListTile(
//                       title: Text(option.text),
//                       value: answers[option.id] ?? false,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           answers[option.id] = value ?? false;
//                           if (!(value ?? false)) {
//                             otherControllers[option.id]?.clear();
//                           }
//                         });
//                       },
//                     ),
//                     if (answers[option.id] ?? false)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: TextField(
//                           controller: otherControllers[option.id],
//                           decoration: const InputDecoration(
//                             hintText: 'Vui lòng ghi rõ',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                   ],
//                 );
//               }
//               return CheckboxListTile(
//                 title: Text(option.text),
//                 value: answers[option.id] ?? false,
//                 onChanged: (bool? value) {
//                   setState(() {
//                     answers[option.id] = value ?? false;
//                   });
//                 },
//               );
//             }).toList(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _submitForm() async {
//     if (!_validateAnswers()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Vui lòng trả lời tất cả các câu hỏi')),
//       );
//       return;
//     }
//
//     try {
//       final userProvider = context.read<UserProvider>();
//       final appointmentProvider = context.read<AppointmentProvider>();
//
//       if (userProvider.userProfile == null) {
//         throw Exception('User not logged in');
//       }
//
//       final success = await appointmentProvider.saveAppointment(
//         // Sử dụng await ở đây
//         userProvider.userProfile!['cccd'],
//         1, // Replace with actual eventScreen ID
//         healthMetrics,
//       );
//
//       if (success) {
//         if (!mounted) return;
//         Navigator.pop(context, true);
//       } else {
//         if (!mounted) return;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(appointmentProvider.error ?? 'Unknown error')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }
//
//   bool _validateAnswers() {
//     _updateHealthMetrics();
//     for (var entry in answers.entries) {
//       if (entry.value == null || entry.value == false) {
//         print("Có câu trả lời bị để trống hoặc không hợp lệ.");
//         return false;
//       }
//     }
//
//     print("Dữ liệu hợp lệ: $healthMetrics");
//     return true;
//   }
//
//   Widget _buildRegistrationStep() {
//     // Implement registration form here
//     return Container(
//       child: Column(
//         children: [
//           _buildQuestionCard(
//             '1. Anh/chị đã từng hiến máu chưa?',
//             [
//               QuestionOption('1.1', 'Có'),
//               QuestionOption('1.2', 'Không'),
//             ],
//           ),
//           _buildQuestionCard(
//             '2. Hiện tại, anh/chị có bị các bệnh: viêm khớp, dạ dày, viêm gan/vàng da, bệnh tim, huyết áp thấp/cao, hen, ho kéo dài, bệnh máu, lao?',
//             [
//               QuestionOption('2.1', 'Có'),
//               QuestionOption('2.2', 'Không'),
//               QuestionOption('2.3', 'Bệnh khác', hasTextField: true),
//             ],
//           ),
//           _buildQuestionCard(
//             '3. Trong vòng 12 tháng gần đây, anh/chị có mắc các bệnh và đã được điều trị khỏi',
//             [
//               QuestionOption('3.1',
//                   'Sốt rét, Giang mai, Lao, Viêm não, Phẫu thuật ngoại khoa?'),
//               QuestionOption('3.2', 'Được truyền máu và các chế phẩm máu?'),
//               QuestionOption('3.3', 'Tiêm Vacxin bệnh dại'),
//               QuestionOption('3.4', 'Không'),
//               QuestionOption('3.5', 'Khác (cụ thể)', hasTextField: true),
//             ],
//           ),
//           _buildQuestionCard(
//             '4. Trong vòng 06 tháng gần đây, anh/chị có bị một trong số các triệu chứng sau không',
//             [
//               QuestionOption('4.1', 'Sút cân nhanh không rõ nguyên nhân'),
//               QuestionOption('4.2', 'Nổi hạch kéo dài'),
//               QuestionOption('4.3', 'Chữa răng, châm cứu?'),
//               QuestionOption('4.4', 'Xăm mình, xổ lỗ tai, lỗ mũi'),
//               QuestionOption('4.5', 'Sử dụng ma túy?'),
//               QuestionOption('4.6',
//                   'Quan hệ tình dục với người nhiễm HIV hoặc người có hành vi nguy cơ lây nhiễm HIV'),
//               QuestionOption('4.7', 'Quan hệ tình dục với người cùng giới'),
//               QuestionOption('4.8', 'Không'),
//               QuestionOption('4.9', 'Mục khác', hasTextField: true),
//             ],
//           ),
//           _buildQuestionCard(
//             '5. Trong 01 tháng gần đây anh/chị có',
//             [
//               QuestionOption('5.1',
//                   'Khỏi bệnh sau khi mắc bệnh viêm đường tiết niệu, viêm da nhiễm trùng, viễm phế quản, viêm phổi, viêm sởi, quai bị, Rubella, Khác'),
//               QuestionOption('5.2', 'Tiêm Vacxin phòng bệnh'),
//               QuestionOption('5.3',
//                   'Đi vào vùng có dịch bệnh lưu hành (sốt rét. sốt xuất huyết, Zika,...)'),
//               QuestionOption('5.4', 'Không'),
//               QuestionOption('5.5', 'Mục khác', hasTextField: true),
//             ],
//           ),
//           _buildQuestionCard(
//             '6. Trong 07 tháng gần đây anh/chị có',
//             [
//               QuestionOption('6.1', 'Bị cảm cúm (ho, nhức đầu, sốt,...'),
//               QuestionOption(
//                   '6.2', 'Dùng thuốc kháng sinh, Aspirin, Corticoid?'),
//               QuestionOption('6.3',
//                   'Tiêm Vacxin phòng viêm gan siêu vi B, Human Papilloma Virus'),
//               QuestionOption('6.4', 'Không'),
//               QuestionOption('6.5', 'Mục khác', hasTextField: true),
//             ],
//           ),
//           _buildQuestionCard(
//             '7. Câu hỏi dành cho phụ nữ',
//             [
//               QuestionOption(
//                   '7.1', 'Hiện có thai, hoặc nuôi con dưới 12 tháng tuổi?'),
//               QuestionOption(
//                   '7.2', 'Có kinh nguyệt trong vòng một tuần hay không?'),
//               QuestionOption('7.3', 'Không'),
//             ],
//           ),
//           _buildQuestionCard(
//             '8. Anh/chị có đồng ý xét nghiệm HIV, nhận thông báo và được tư vấn khi kết quả xét nghiệm HIV nghi ngờ hoặc dương tính?',
//             [
//               QuestionOption('8.1', 'Có'),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       if (_currentStep > 0) {
//                         _currentStep--;
//                       }
//                     });
//                     // Navigator.pop(context); <-- Nếu dùng push mới dùng cái này
//                   },
//                   child: const Text('Quay về'),
//                 ),
//                 ElevatedButton(
//                   onPressed: _submitForm,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).primaryColor,
//                   ),
//                   child: const Text('Hoàn thành'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class QuestionOption {
//   final String id;
//   final String text;
//   final bool hasTextField;
//
//   QuestionOption(this.id, this.text, {this.hasTextField = false});
// }
