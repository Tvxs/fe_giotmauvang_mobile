import 'package:fe_giotmauvang_mobile/models/Appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/AppointmentProvider.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final int appointmentId;

  const AppointmentDetailScreen({
    Key? key,
    required this.appointmentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đặt hẹn'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
          if (appointmentProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Tìm kiếm thông tin đặt hẹn theo ID
          final appointment = appointmentProvider.getAppointmentById(appointmentId);

          if (appointment == null) {
            return const Center(child: Text('Không tìm thấy thông tin đặt hẹn'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header với thông tin đơn giản về sự kiện
                _buildHeaderInfo(appointment),

                SizedBox(height: 16),

                // Các thông tin chi tiết về lịch hẹn
                DetailInfoCard(appointment: appointment),

                SizedBox(height: 16),

                // Thông tin trạng thái
                _buildStatusInfo(appointment),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderInfo(Appointment appointment) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Hình ảnh biểu tượng cho sự kiện
            Image.asset(
              'assets/blood.png',
              width: 56,
              height: 56,
            ),
            SizedBox(width: 16),
            // Thông tin ngắn gọn về sự kiện
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    appointment.event?.name ?? 'Thông tin sự kiện không có',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Địa điểm: ${appointment.event?.donationUnitDTO.location ?? 'Chưa có địa điểm'}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),

                  Text(
                    'Ngày: ${DateFormat('dd/MM/yyyy').format(appointment.event?.eventDate ?? DateTime.now()) ??'Chưa có ngày'}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusInfo(Appointment appointment) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trạng thái:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800]),
            ),
            Text(
              appointment.status ?? 'Chưa xác định',
              style: TextStyle(
                color: appointment.status == 'ACTIVE'
                    ? Colors.green
                    : appointment.status == 'CANCELLED'
                    ? Colors.red
                    : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailInfoCard extends StatelessWidget {
  final Appointment appointment;

  const DetailInfoCard({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin chi tiết lịch hẹn:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            InfoRow(label: 'Thời gian bắt đầu:', value: '${appointment.event?.eventStartTime.format(context)}'),
            InfoRow(label: 'Thời gian kết thúc:', value: '${appointment.event?.eventEndTime.format(context)}'),
            InfoRow(label: 'Đơn vị hiến máu:', value: appointment.event?.donationUnitDTO.name ?? 'Chưa có thông tin'),
            InfoRow(label: 'Địa chỉ đơn vị:', value: appointment.event?.donationUnitDTO.location ?? 'Chưa có địa chỉ'),
            InfoRow(label: 'Số lượng đăng ký:', value: '${appointment.event?.currentRegistrations ?? 0} người'),
            InfoRow(label: 'Mô tả:', value: appointment.event?.status ?? 'Chưa có mô tả'),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
