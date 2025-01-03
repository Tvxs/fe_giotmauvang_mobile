import 'dart:async';
import 'dart:convert';
import 'package:fe_giotmauvang_mobile/services/QAService.dart';
import 'package:flutter/material.dart';
import '../services/ApiService.dart';

class QAProvider extends ChangeNotifier {
  final QAService _qaService = QAService();
  List<dynamic> faqList = [];
  bool isLoading = false;
  String errorMessage = '';
  Future<Map<String, dynamic>>? eventData;
  // Lấy sự kiện theo khoảng thời gian và đơn vị
  Future<void> fetchQA() async {
    try {
      isLoading = true;
      notifyListeners();
      // Lấy dữ liệu sự kiện từ API
      final response = await _qaService.getAllQA();
      faqList = response['faqDTOList'] ?? [];
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}


