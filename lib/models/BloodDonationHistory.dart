import 'package:fe_giotmauvang_mobile/models/Appointment.dart';
import 'package:fe_giotmauvang_mobile/models/User.dart';

class BloodDonationHistory {
  final int id;
  final int? bloodAmount;
  final DateTime donationDateTime;
  final String? donationLocation;
  final String? donationType;
  final DateTime? nextDonationEligibleDate;
  final String? notes;
  final String? reactionAfterDonation;
  final Appointment? appointment;  // Changed from appointmentId
  final User user;                // Changed from userId to User object

  BloodDonationHistory({
    required this.id,
    this.bloodAmount,
    required this.donationDateTime,
    this.donationLocation,
    this.donationType,
    this.nextDonationEligibleDate,
    this.notes,
    this.reactionAfterDonation,
    this.appointment,
    required this.user,
  });

  factory BloodDonationHistory.fromJson(Map<String, dynamic> json) {
    return BloodDonationHistory(
      id: json['id'],
      bloodAmount: json['blood_amount'],
      donationDateTime: DateTime.parse(json['donation_date_time']),
      donationLocation: json['donation_location'],
      donationType: json['donation_type'],
      nextDonationEligibleDate: json['next_donation_eligible_date'] != null
          ? DateTime.parse(json['next_donation_eligible_date'])
          : null,
      notes: json['notes'],
      reactionAfterDonation: json['reaction_after_donation'],
      appointment: json['appointment'] != null
          ? Appointment.fromJson(json['appointment'])
          : null,
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'blood_amount': bloodAmount,
      'donation_date_time': donationDateTime.toIso8601String(),
      'donation_location': donationLocation,
      'donation_type': donationType,
      'next_donation_eligible_date': nextDonationEligibleDate?.toIso8601String(),
      'notes': notes,
      'reaction_after_donation': reactionAfterDonation,
      'appointment': appointment?.toJson(),
      'user': user.toJson(),
    };
  }
}