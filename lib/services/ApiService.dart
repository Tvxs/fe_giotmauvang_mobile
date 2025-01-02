import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.72.1:8080'; // Thay bằng URL API của bạn

  ApiService();
  //Lấy phiếu đăng ký có trạng thái là pending từ phía server nhé
  Future<Map<String, dynamic>> getAppointmentPendingUser(String username) async {
 // Lấy Bearer token từ SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('auth_token');
    if (token == null) {
      throw Exception('Token không tồn tại');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/appointments/by-user-pending?username=$username'),
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


  // Update lại trạng thái lịch hẹn thành CANCLE đối với người dùng ( Không có xóa nhé)
  Future<Map<String, dynamic>> updateAppointmentStatus(int appointmentId, String status) async {
    final url = Uri.parse('$baseUrl/appointments/status?id=$appointmentId&&status=$status');
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


  // Tìm kiếm event dựa trên ngày + Unit
  Future<Map<String, dynamic>> getEventsByDateRange(
      DateTime startDate,
      DateTime endDate,
      {String? unitId}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('auth_token');
    if (token == null) {
      throw Exception('Token không tồn tại');
    }
    if (unitId == 'Tất cả'){
      unitId = null;
    }
    // Cắt phần thời gian trong ngày, chỉ lấy phần ngày
    final startDateString = startDate.toIso8601String().split('T').first; // Lấy phần ngày
    final endDateString = endDate.toIso8601String().split('T').first;     // Lấy phần ngày
    final url = Uri.parse(
        '$baseUrl/events/get-by-date-range?startDate=$startDateString&endDate=$endDateString${unitId != null ? '&unitId=$unitId' : ''}');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        // In ra nội dung body của phản hồi để kiểm tra
        print('Response body: ${response.body}');

        // Giải mã JSON và kiểm tra kiểu dữ liệu trả về
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is Map<String, dynamic>) {
          return decodedResponse;
        } else {
          throw Exception('Dữ liệu trả về không phải Map<String, dynamic>');
        }
      } catch (e) {
        throw Exception('Lỗi khi giải mã JSON: $e');
      }
    } else {
      throw Exception('Lỗi khi gọi API: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> getAllUnits() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('auth_token');
    if (token == null) {
      throw Exception('Token không tồn tại');
    }

    final url = Uri.parse('$baseUrl/units/get-all');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw Exception('Error decoding response body: $e');
      }
    } else {
      throw Exception('Lỗi khi gọi API: ${response.statusCode} ${response.reasonPhrase}');
    }
  }


}
