import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Appointment.dart';
import '../../providers/AppointmentProvider.dart';

class AppointmentHistoryScreen extends StatefulWidget {
  @override
  _HistoryAppointState createState() => _HistoryAppointState();
}

class _HistoryAppointState extends State<AppointmentHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString('user_data');
      Map<String, dynamic> userData = jsonDecode(jsonString!);

      await context.read<AppointmentProvider>().fetchAppointments(userData['username']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Lịch sử đặt hẹn'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop(); // Quay lại màn hình trước
            } else {
              // Nếu không thể quay lại, điều hướng đến một màn hình khác nếu cần
              Navigator.of(context).pushReplacementNamed('/home');
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Expanded(
                child: Consumer<AppointmentProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (provider.error != null) {
                      return Center(child: Text(provider.error!));
                    }

                    return ListView.builder(
                      itemCount: provider.appointments.length,
                      itemBuilder: (context, index) {
                        final appointment = provider.appointments[index];
                        return AppointmentCard(
                          appointment: appointment,
                          statusMap: provider.statusMap,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// widgets/appointment_card.dart
class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final Map<String, Map<String, dynamic>> statusMap;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.statusMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,  // Thêm bóng cho thẻ
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),  // Bo góc
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh
            Image.asset(
              'assets/blood.png',  // Đảm bảo đường dẫn chính xác
              width: 56,
              height: 56,
            ),
            SizedBox(width: 16),
            // Thông tin sự kiện
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.event?.name ?? 'Thông tin sự kiện không có',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    'assets/local222.png',
                    appointment.event?.donationUnitDTO.location ?? 'Không có địa điểm',
                  ),
                  _buildInfoRow(
                    'assets/alarm.png',
                    '${appointment.event?.eventStartTime.format(context)} - ${appointment.event?.eventDate ?? ''}',
                  ),
                ],
              ),
            ),
            // Trạng thái và hành động
            _buildStatusAndAction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String iconPath, String text) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Image.asset(iconPath, width: 16, height: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusAndAction(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusMap[appointment.status]?['color'] ?? Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            statusMap[appointment.status]?['text'] ?? 'Chưa xác định',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Chuyển đến màn hình chi tiết với ID
            Navigator.pushNamed(
              context,
              '/appointment/${appointment.id}',  // Truyền appointmentId vào URL
            );
          },
          child: const Text(
          'Xem chi tiết',
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }

}
