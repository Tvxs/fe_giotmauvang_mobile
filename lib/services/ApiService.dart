import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.72.1:8080/appointments'; // Thay bằng URL API của bạn

  ApiService();

  Future<Map<String, dynamic>> getAppointmentPendingUser(String username) async {
 // Lấy Bearer token từ SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('auth_token');
    if (token == null) {
      throw Exception('Token không tồn tại');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/by-user-pending?username=$username'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Lỗi khi gọi API: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
  Future<Map<String, dynamic>> updateAppointmentStatus(int appointmentId, String status) async {
    final url = Uri.parse('$baseUrl/status?id=$appointmentId&&status=$status');
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('auth_token');
    final body = jsonEncode({
      'id': appointmentId,  // Gửi id dưới dạng int
      'status': status,
    });

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Lỗi khi cập nhật trạng thái: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Có lỗi khi gửi yêu cầu: $e');
    }
  }
}
