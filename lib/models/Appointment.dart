import 'package:fe_giotmauvang_mobile/models/Event.dart';
import 'package:fe_giotmauvang_mobile/models/User.dart';

class Appointment {
  final int id;
  final DateTime appointmentDateTime;
  final int? bloodAmount;
  final DateTime? nextDonationEligibleDate;
  final int status;
  final Event? event;  // Changed from eventId
  final User? user;    // Changed from userCccd to User object

  Appointment({
    required this.id,
    required this.appointmentDateTime,
    this.bloodAmount,
    this.nextDonationEligibleDate,
    required this.status,
    this.event,
    this.user,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      appointmentDateTime: DateTime.parse(json['appointment_date_time']),
      bloodAmount: json['blood_amount'],
      nextDonationEligibleDate: json['next_donation_eligible_date'] != null
          ? DateTime.parse(json['next_donation_eligible_date'])
          : null,
      status: json['status'],
      event: json['event'] != null ? Event.fromJson(json['event']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointment_date_time': appointmentDateTime.toIso8601String(),
      'blood_amount': bloodAmount,
      'next_donation_eligible_date': nextDonationEligibleDate?.toIso8601String(),
      'status': status,
      'event': event?.toJson(),
      'user': user?.toJson(),
    };
  }
}