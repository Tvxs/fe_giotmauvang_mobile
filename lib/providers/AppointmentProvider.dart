import 'package:fe_giotmauvang_mobile/services/ApiService.dart';
import 'package:flutter/foundation.dart';
import '../models/Appointment.dart';

class AppointmentProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Appointment> _appointments = [];
  Appointment? _currentAppointment;
  bool _isLoading = false;
  String? _error;

  List<Appointment> get appointments => _appointments;
  Appointment? get currentAppointment => _currentAppointment;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasPendingAppointment => _appointments.any((a) => a.status == 0);

  Future<void> loadUserAppointments(String username) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _apiService.getUserAppointments(username);
      _appointments = (response['data'] as List)
          .map((data) => Appointment.fromJson(data))
          .toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveAppointment(String username, int eventId, Map<String, dynamic> healthMetrics) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _apiService.saveAppointment(username, eventId, healthMetrics);
      if (response['success']) {
        await loadUserAppointments(username);
        return true;
      }
      _error = response['message'];
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}