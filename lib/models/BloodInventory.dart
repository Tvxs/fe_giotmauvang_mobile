import 'package:fe_giotmauvang_mobile/models/Appointment.dart';

class BloodInventory {
  final int id;
  final String? bloodType;
  final DateTime? expirationDate;
  final DateTime? lastUpdated;
  final int quantity;
  final Appointment? appointment;  // Changed from appointmentId

  BloodInventory({
    required this.id,
    this.bloodType,
    this.expirationDate,
    this.lastUpdated,
    required this.quantity,
    this.appointment,
  });

  factory BloodInventory.fromJson(Map<String, dynamic> json) {
    return BloodInventory(
      id: json['id'],
      bloodType: json['blood_type'],
      expirationDate: json['expiration_date'] != null
          ? DateTime.parse(json['expiration_date'])
          : null,
      lastUpdated: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'])
          : null,
      quantity: json['quantity'],
      appointment: json['appointment'] != null
          ? Appointment.fromJson(json['appointment'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'blood_type': bloodType,
      'expiration_date': expirationDate?.toIso8601String(),
      'last_updated': lastUpdated?.toIso8601String(),
      'quantity': quantity,
      'appointment': appointment?.toJson(),
    };
  }
}