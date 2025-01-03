import 'package:fe_giotmauvang_mobile/models/Event.dart';
import 'package:fe_giotmauvang_mobile/models/User.dart';

class Appointment {
  final int id;
  final String appointmentDateTime;
  final int? bloodAmount;
  final String status;
  final String? nextDonationEligibleDate;
  final int eventId;  // Changed from eventId
  final String userId;    // Changed from userCccd to User object
  final int? bloodDonationHistoryId;
  final int? healthCheckId;
  final int? bloodInventoryId;
  Event? event;


  Appointment({
    required this.id,
    required this.appointmentDateTime,
    required this.bloodAmount,
    required this.status,
    this.bloodDonationHistoryId,
    required this.healthCheckId,
    required this.userId,
    required this.eventId,
    this.nextDonationEligibleDate,
    this.bloodInventoryId,
    this.event,

  });
  // factory Appointment.fromJson(Map<String, dynamic> json) {
  //   return Appointment(
  //     id: json['id'] as int,
  //     appointmentDateTime: json['appointmentDateTime']! as String,
  //     bloodAmount: json['bloodAmount'] as int,
  //     status: json['status'] as String,
  //     bloodDonationHistoryId: json['bloodDonationHistoryId'] as int?,
  //     healthCheckId: json['healthCheckId'] as int,
  //     userId: json['userId'] as String,
  //     eventId: json['eventId'] as int,
  //     nextDonationEligibleDate: json['nextDonationEligibleDate'] as String?,
  //     bloodInventoryId: json['bloodInventoryId'] as int?,
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointment_date_time': appointmentDateTime,
      'bloodAmount': bloodAmount,
      'next_donation_eligible_date': nextDonationEligibleDate,
      'status': status,
      'eventScreen': eventId,
      'user': userId,
    };
  }
  factory Appointment.fromJson(Map<String,dynamic> json){
    return Appointment(
        id: json['id'],
        appointmentDateTime: json['appointmentDateTime'],
        bloodAmount: json['BloodAmount'],
        status: json['status'],
        healthCheckId: json['healthCheckId'],
        userId: json['userId'],
        eventId: json['eventId']);
  }
}