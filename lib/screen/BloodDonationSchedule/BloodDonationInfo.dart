import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/AppointmentProvider.dart';
import '../../widgets/custom_app_bar.dart';

class BloodDonationInfo extends StatelessWidget {
  Future<Map<String, dynamic>> _loadUserDataFromSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userJson = sharedPreferences.getString('user_data');
    if (userJson != null) {
      return jsonDecode(userJson) as Map<String, dynamic>;
    } else {
      throw Exception('Không tìm thấy thông tin người dùng trong SharedPreferences.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadUserDataFromSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Thông tin đăng ký hiến máu'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Thông tin đăng ký hiến máu'),
            ),
            body: Center(child: Text('Lỗi: ${snapshot.error}')),
          );
        }

        final userData = snapshot.data!;
        final username = userData['username'] as String;

        // Gọi hàm fetchAppointmentPendingUser để tải thông tin cuộc hẹn
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<AppointmentProvider>(context, listen: false)
              .fetchAppointmentPendingUser(username);
        });

        return _buildMainUI(context, userData);
      },
    );
  }

  Widget _buildMainUI(BuildContext context, Map<String, dynamic> userData) {
    final userInfo = userData['userInfoDTO'] as Map<String, dynamic>?;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(106),
        child: NavBarCustom(),
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
          final appointmentData = appointmentProvider.appointmentData;
          final isLoading = appointmentProvider.isLoading;
          final hasAppointment = appointmentProvider.appointmentData != null;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildSectionTitle('Thông tin cá nhân'),
                          _buildCard(
                            child: Column(
                              children: [
                                _buildInfoText('Họ và tên', userInfo?['fullName']),
                                _buildInfoText('Số CMND', userData['username']),
                                _buildInfoText('Ngày sinh', userInfo?['dob']),
                                _buildInfoText('Giới tính', userInfo?['sex']),
                                _buildInfoText('Nghề nghiệp', userData['job']),
                                _buildInfoText('Đơn vị', userData['organization']),
                                _buildInfoText('Nhóm máu', userData['bloodType']),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildSectionTitle('Thông tin liên hệ'),
                          _buildCard(
                            child: Column(
                              children: [
                                _buildInfoText('Địa chỉ liên lạc', userData['address']),
                                _buildInfoText('Điện thoại di động', userData['phone']),
                                _buildInfoText('Email', userData['email']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Phần "Phiếu đăng ký hiến máu" được hiển thị phía dưới "Thông tin cá nhân"
                _buildSectionTitle('Phiếu đăng ký hiến máu'),
                if (appointmentData == null) ...[
                  const Center(
                    child: Text(
                      'Chưa đăng ký hiến máu',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ] else if (appointmentData['status'] == 'PENDING') ...[
                  Column(
                    children: [
                      const Icon(
                        Icons.description,
                        size: 100,
                        color: Colors.grey,
                      ),
                      Text(
                        'Bạn đã đăng ký hiến máu',
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Ngày hẹn: ${appointmentData['appointmentDateTime']}',
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);

                    if (appointmentProvider.appointmentData == null) {
                      // Nếu không có phiếu đăng ký hiến máu, chuyển hướng đến trang tìm kiếm sự kiện
                      Navigator.pushNamed(context, '/searchBloodDonationEvent');
                    } else {
                      // Kiểm tra nếu có phiếu đăng ký và có id
                      final appointmentData = appointmentProvider.appointmentData;
                      final appointmentId = appointmentData?['id'];

                      if (appointmentId != null) {
                        // Nếu có id, thực hiện hủy phiếu đăng ký
                        await appointmentProvider.updateAppointmentStatus(appointmentId, "CANCELED");

                        // Sau khi hủy thành công, gọi lại API để tải lại dữ liệu và cập nhật trạng thái
                        await appointmentProvider.fetchAppointmentPendingUser(appointmentProvider.appointmentData?['username']);

                        // Hiển thị SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Phiếu đăng ký hiến máu đã được hủy thành công.')),
                        );
                      } else {
                        // Nếu không có id, hiển thị thông báo lỗi
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Lỗi: Không tìm thấy ID phiếu đăng ký.')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  ),
                  child: Consumer<AppointmentProvider>(
                    builder: (context, appointmentProvider, child) {
                      return Text(
                        appointmentProvider.appointmentData == null
                            ? 'Đăng ký hiến máu'
                            : 'Hủy phiếu đăng ký',
                        style: const TextStyle(fontSize: 18),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Tiêu đề phần thông tin
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(28, 82, 145, 1),
        ),
      ),
    );
  }

  // Card chứa thông tin
  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  // Text thông tin cá nhân
  Widget _buildInfoText(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: ${value ?? 'Không có thông tin'}',
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
