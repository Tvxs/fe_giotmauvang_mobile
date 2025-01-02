import 'dart:ffi';

import 'package:flutter/material.dart';
import '../services/ApiService.dart';

class AppointmentProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _appointmentData;
  bool _isLoading = false;

  Map<String, dynamic>? get appointmentData => _appointmentData;
  bool get isLoading => _isLoading;

  Future<void> fetchAppointmentPendingUser(String username) async {
    _isLoading = true;
    notifyListeners();

    try {
         final response = await _apiService.getAppointmentPendingUser(username);
      if (response['code'] == 200) {
         _appointmentData = response['appointmentDTO'];

      }

    } catch (e) {
      _appointmentData = null;
      debugPrint('Error fetching appointment: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAppointmentStatus(int appointmentId, String status) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.updateAppointmentStatus(appointmentId, status);
      if (response['code'] == 200) {
        _appointmentData = response['appointmentDTO'];  // Cập nhật dữ liệu phiếu đăng ký
      }
    } catch (e) {
      debugPrint('Error updating appointment status: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
