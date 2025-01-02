import 'dart:async';
import 'package:flutter/material.dart';
import '../services/ApiService.dart';

class EventProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<dynamic> events = [];
  bool isLoading = false;
  String errorMessage = '';

  // Lấy sự kiện theo khoảng thời gian và đơn vị
  Future<void> fetchEvents(DateTime startDate, DateTime endDate, {String? unitId}) async {
    try {
      isLoading = true;
      notifyListeners();

      // Lấy dữ liệu sự kiện từ API
      final response = await _apiService.getEventsByDateRange(startDate, endDate, unitId: unitId);
      events = response['eventDTOList'] ?? [];
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

}
