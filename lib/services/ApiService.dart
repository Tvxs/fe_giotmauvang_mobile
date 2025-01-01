import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/appointments';

  Future<Map<String, dynamic>> getAllAppointments() async {
    final response = await http.get(Uri.parse(baseUrl));
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> getAppointmentById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/get/$id'));
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> saveAppointment(
      String username, int eventId, Map<String, dynamic> healthMetrics) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save')
          .replace(queryParameters: {'username': username, 'eventId': eventId.toString()}),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(healthMetrics),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> getUserAppointments(String username) async {
    final response = await http.get(
      Uri.parse('$baseUrl/by-user').replace(queryParameters: {'username': username}),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> getPendingAppointments(String username) async {
    final response = await http.get(
      Uri.parse('$baseUrl/by-user-pending')
          .replace(queryParameters: {'username': username}),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> updateAppointmentStatus(
      int id, String status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/status')
          .replace(queryParameters: {'id': id.toString(), 'status': status}),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> deleteAppointment(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to process request: ${response.statusCode}');
  }
}