import 'package:flutter/cupertino.dart';

import '../services/ApiService.dart';

class UnitProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<dynamic> units = [];
  bool isLoading = false;
  String errorMessage = '';

  // Lấy sự kiện theo khoảng thời gian và đơn vị
  Future<void> fetchUnit() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _apiService.getAllUnits();

      if (response.containsKey('donationUnitList')) {
        units = response['donationUnitList'] ?? [];  // Assuming the list is in this field
      } else {
        throw Exception("API response does not contain 'donationUnitDTO' key.");
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      // Optionally, you could add logging here to help debug
    }
  }
}