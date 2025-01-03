import 'dart:ffi';

import 'package:flutter/material.dart';
import '../models/Appointment.dart';
import '../models/DTO/ApiResponse.dart';
import '../models/Event.dart';
import '../services/ApiService.dart';

class AppointmentProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _appointmentData;
  bool _isLoading = false;
  String errorMessage = '';
  Map<String, dynamic>? get appointmentData => _appointmentData;
  bool get isLoading => _isLoading;
  Map<String, dynamic>? saveResult;
  List<Appointment> _appointments = [];
  String? _error;
  String? get error => _error;

  List<Appointment> get appointments => _appointments;
  final Map<String, Map<String, dynamic>> statusMap = {
    'PENDING': {
      'text': 'Đang chờ',
      'color': Colors.yellow,
    },
    'CONFIRMED': {
      'text': 'Đã xác nhận',
      'color': Colors.blue,
    },
    'CANCELED': {
      'text': 'Đã xoá',
      'color': Colors.red,
    },
    'COMPLETED': {
      'text': 'Hoàn thành',
      'color': Colors.green,
    },
  };




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
  Appointment? getAppointmentById(int id) {
    try {
      return appointments.firstWhere((appointment) => appointment.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> fetchAppointments(String username) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.getUserAppointment(username);

      if (response == null || response['appointmentDTOList'] == null) {
        // Nếu không có dữ liệu hoặc danh sách trống
        _appointments = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Trích xuất danh sách từ 'appointmentDTOList'
      List<dynamic> appointmentList = response['appointmentDTOList'] as List<dynamic>;
      List<Appointment> fetchedAppointments = [];

      for (var appointmentData in appointmentList) {
        Appointment appointment = Appointment.fromJson(appointmentData);
        if (appointment.eventId.toString().isNotEmpty) {
          final eventResponse = await _apiService.getEventById(appointment.eventId.toString());
          appointment.event = Event.fromJson(eventResponse['eventDTO']);
        }
        fetchedAppointments.add(appointment);
      }

      _appointments = fetchedAppointments;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
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

  //Đặt lịch
  Future<bool> saveAppointment(
      String username, String eventId, Map<String, dynamic> healthMetrics) async {
    _isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final response = await _apiService.saveAppointment(
        username: username,
        eventId: eventId,
        healthMetrics: healthMetrics,
      );

      ApiResponse apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.success) {
        saveResult = apiResponse.data;
        return true;
      } else {
        errorMessage = apiResponse.message;
        return false;
      }
    } catch (e) {
      errorMessage = 'Exception: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false; // Trả về false nếu có lỗi
  }

}
