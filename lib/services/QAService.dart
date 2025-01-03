import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QAService {
  static const String baseUrl = 'http://192.168.72.1:8080'; // Thay bằng URL API của bạn

  QAService();
  //Lấy phiếu đăng ký có trạng thái là pending từ phía server nhé

  Future<Map<String, dynamic>> getAllQA() async {

    final url = Uri.parse('$baseUrl/faq');
    final response = await http.get(
      url,
      headers: {
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
