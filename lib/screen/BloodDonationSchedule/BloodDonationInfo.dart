// import 'package:flutter/material.dart';
//
// class BloodDonationInfo extends StatelessWidget {
//   const BloodDonationInfo({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Thông tin đăng ký hiến máu',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Personal Information Section
//               _buildSection(
//                 'Thông tin cá nhân',
//                 [
//                   _buildInfoRow('Họ và tên:', 'Dương Nguyễn Chí Tín'),
//                   _buildInfoRow('Số CMND:', '352736016'),
//                   _buildInfoRow('Ngày sinh:', '09/05/2003'),
//                   _buildInfoRow('Giới tính:', 'Nam'),
//                   _buildInfoRow('Nghề nghiệp:', 'Sinh viên'),
//                   _buildInfoRow('Đơn vị:', '-'),
//                   _buildInfoRow('Nhóm máu:', '-'),
//                 ],
//               ),
//
//               // Contact Information Section
//               _buildSection(
//                 'Thông tin liên hệ',
//                 [
//                   _buildInfoRow('Địa chỉ liên lạc:', '38 đường 904, Phường Hiệp Phú, Thành Phố Thủ Đức, Tp Hồ Chí Minh'),
//                   _buildInfoRow('Điện thoại di động:', '0706389781'),
//                   _buildInfoRow('Điện thoại bàn:', '-'),
//                   _buildInfoRow('Email:', 'chitin952003@gmail.com'),
//                 ],
//               ),
//
//               // Blood Donation Registration Section
//               _buildSection(
//                 'Phiếu đăng ký hiến máu',
//                 [
//                   Center(
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           'assets/empty.png', // Make sure to add this image to your assets
//                           width: 140,
//                         ),
//                         const Text('Chưa có phiếu đăng ký hiến máu'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//
//               // Register Button
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Add registration logic here
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     backgroundColor: Colors.blue,
//                   ),
//                   child: const Text(
//                     'Đăng ký hiến máu',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSection(String title, List<Widget> children) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(8),
//                 topRight: Radius.circular(8),
//               ),
//             ),
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: children,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// Phần 2
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
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
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           _buildStepItem(
//             isActive: _currentStep >= 0,
//             isComplete: _currentStep > 0,
//             icon: Icons.calendar_today,
//             label: 'Thời gian & địa điểm',
//           ),
//           Expanded(
//             child: Container(
//               height: 2,
//               color: _currentStep > 0 ? Colors.blue : Colors.grey[300],
//             ),
//           ),
//           _buildStepItem(
//             isActive: _currentStep >= 1,
//             isComplete: _currentStep > 1,
//             icon: Icons.description,
//             label: 'Phiếu đăng ký hiến máu',
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStepItem({
//     required bool isActive,
//     required bool isComplete,
//     required IconData icon,
//     required String label,
//   }) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: isActive ? Colors.blue : Colors.grey[300],
//           ),
//           child: Icon(
//             isComplete ? Icons.check : icon,
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             color: isActive ? Colors.blue : Colors.grey,
//             fontSize: 12,
//           ),
//         ),
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
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey[300]!),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 DateFormat('dd/MM/yyyy').format(selectedDate),
//                 style: const TextStyle(fontSize: 16),
//               ),
//               const Icon(Icons.calendar_today),
//             ],
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
//           subtitle: '466 Nguyễn Thị Minh Khai Phường 02, Quận 3, Tp Hồ Chí Minh',
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLocationDropdown(String label, String value, {String? subtitle}) {
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
//                     Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
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
//                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
//   Widget _buildRegistrationStep() {
//     // Implement registration form here
//     return Container();
//   }
//}


// Phan 2:
// screens/blood_donation_info.dart
import 'package:fe_giotmauvang_mobile/providers/AppointmentProvider.dart';
import 'package:fe_giotmauvang_mobile/providers/UserProvider.dart';
import 'package:fe_giotmauvang_mobile/screen/BloodDonationSchedule/BloodDonationBooking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BloodDonationInfo extends StatefulWidget {
  const BloodDonationInfo({Key? key}) : super(key: key);

  @override
  State<BloodDonationInfo> createState() => _BloodDonationInfoState();
}

class _BloodDonationInfoState extends State<BloodDonationInfo> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userProvider = context.read<UserProvider>();
      final appointmentProvider = context.read<AppointmentProvider>();
      await userProvider.loadProfile();
      if (userProvider.userProfile != null) {
        await appointmentProvider.loadUserAppointments(
          userProvider.userProfile!['cccd'],
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<UserProvider, AppointmentProvider>(
        builder: (context, userProvider, appointmentProvider, child) {
          if (userProvider.isLoading || appointmentProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userProvider.error != null) {
            return Center(child: Text(userProvider.error!));
          }

          final userProfile = userProvider.userProfile;
          if (userProfile == null) {
            return const Center(child: Text('Không thể tải thông tin người dùng'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông tin đăng ký hiến máu',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildUserInfoSection(userProfile),
                  const SizedBox(height: 20),
                  _buildDonationSection(context, appointmentProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserInfoSection(Map<String, dynamic> userProfile) {
    final userInfo = userProfile['userInfo'] as Map<String, dynamic>?;

    return _buildSection(
      'Thông tin cá nhân',
      [
        _buildInfoRow('Họ và tên:', userInfo?['full_name'] ?? '-'),
        _buildInfoRow('Số CCCD:', userProfile['cccd'] ?? '-'),
        _buildInfoRow('Ngày sinh:', userInfo?['dob'] ?? '-'),
        _buildInfoRow('Giới tính:', userInfo?['sex'] ?? '-'),
        _buildInfoRow('Địa chỉ:', userInfo?['address'] ?? '-'),
        _buildInfoRow('Email:', userProfile['email'] ?? '-'),
        _buildInfoRow('Điện thoại:', userProfile['phone'] ?? '-'),
      ],
    );
  }

  Widget _buildDonationSection(BuildContext context, AppointmentProvider appointmentProvider) {
    if (!appointmentProvider.hasPendingAppointment) {
      return Column(
        children: [
          _buildSection(
            'Phiếu đăng ký hiến máu',
            [
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/empty.png', width: 140),
                    const Text('Chưa có phiếu đăng ký hiến máu'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BloodDonationBooking(),
                  ),
                );
                if (result == true) {
                  final userProvider = context.read<UserProvider>();
                  if (userProvider.userProfile != null) {
                    await appointmentProvider.loadUserAppointments(
                      userProvider.userProfile!['cccd'],
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Đăng ký hiến máu',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      );
    }

    final appointment = appointmentProvider.appointments.first;
    return _buildSection(
      'Phiếu đăng ký hiến máu',
      [
        _buildInfoRow('Ngày đăng ký:', appointment.appointmentDateTime.toString()),
        _buildInfoRow('Trạng thái:', _getStatusText(appointment.status)),
      ],
    );
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return 'Chờ xác nhận';
      case 1:
        return 'Đã xác nhận';
      case 2:
        return 'Đã hoàn thành';
      case 3:
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: TextStyle(color: Colors.grey.shade600)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}