import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/ApiService.dart';

class EventProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<dynamic> events = [];
  bool isLoading = false;
  String errorMessage = '';
  Future<Map<String, dynamic>>? eventData;
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
  // Hàm lấy thông tin sự kiện từ API
  Future<Map<String, dynamic>> getEventById(String eventId) async {
    try {
      // Gọi API thông qua _apiService
      final response = await _apiService.getEventById(eventId);

      // Kiểm tra nếu response có mã trạng thái 'code' là 200 (thành công)
      if (response['code'] == 200) {

        return response['eventDTO']; // Trả về dữ liệu sự kiện
      } else {
        // Nếu không thành công, ném lỗi với thông báo từ API
        throw Exception('Failed to load event: ${response['message']}');
      }
    } catch (e) {
      // Xử lý lỗi và cập nhật thông báo lỗi
      throw Exception('Failed to load event data: $e');  // Ném lỗi nếu có
    }
  }
  }


