import 'dart:convert';

import 'package:fe_giotmauvang_mobile/models/Appointment.dart';

enum HealthCheckResult {
  PASS,
  FAIL
}

class Healthcheck {
  int? id;
  String healthMetrics; // JSON string format
  String? notes;
  Appointment? appointment;
  HealthCheckResult? result;

  Healthcheck({
    this.id,
    required this.healthMetrics,
    this.notes,
    this.appointment,
    this.result,
  });

  // Convert from JSON
  factory Healthcheck.fromJson(Map<String, dynamic> json) {
    return Healthcheck(
      id: json['id'] as int?,
      healthMetrics: json['healthMetrics'] as String,
      notes: json['notes'] as String?,
      appointment: json['appointment'] != null
          ? Appointment.fromJson(json['appointment'] as Map<String, dynamic>)
          : null,
      result: json['result'] != null
          ? HealthCheckResult.values.firstWhere(
              (e) => e.toString().split('.').last == json['result']
      )
          : null,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'healthMetrics': healthMetrics,
      'notes': notes,
      'appointment': appointment?.toJson(),
      'result': result?.toString().split('.').last,
    };
  }

  // Validate health check
  bool isValidHealthCheck() {
    try {
      // Parse healthMetrics JSON string to Map
      final metrics = json.decode(healthMetrics) as Map<String, dynamic>;

      // Check conditions
      if (!metrics['hasChronicDiseases'] &&
          !metrics['hasRecentDiseases'] &&
          !metrics['hasSymptoms'] &&
          !metrics['isPregnantOrNursing'] &&
          metrics['HIVTestAgreement']) {
        result = HealthCheckResult.PASS;
        return true;
      } else {
        result = HealthCheckResult.FAIL;
        return false;
      }
    } catch (e) {
      // Handle JSON parsing error
      print('Error parsing healthMetrics: $e');
      result = HealthCheckResult.FAIL;
      return false;
    }
  }

  // Copy with method for immutability
  Healthcheck copyWith({
    int? id,
    String? healthMetrics,
    String? notes,
    Appointment? appointment,
    HealthCheckResult? result,
  }) {
    return Healthcheck(
      id: id ?? this.id,
      healthMetrics: healthMetrics ?? this.healthMetrics,
      notes: notes ?? this.notes,
      appointment: appointment ?? this.appointment,
      result: result ?? this.result,
    );
  }
}
