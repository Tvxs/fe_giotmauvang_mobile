import 'package:fe_giotmauvang_mobile/models/DonationUnit.dart';
import 'package:flutter/material.dart';

class Event {
  final int id;
  final int? currentRegistrations;
  final DateTime eventDate;
  final TimeOfDay eventEndTime;
  final TimeOfDay eventStartTime;
  final int? maxRegistrations;
  final String? name;
  final int status;
  final DonationUnit donationUnit;  // Changed from donationUnitId

  Event({
    required this.id,
    this.currentRegistrations,
    required this.eventDate,
    required this.eventEndTime,
    required this.eventStartTime,
    this.maxRegistrations,
    this.name,
    required this.status,
    required this.donationUnit,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      currentRegistrations: json['current_registrations'],
      eventDate: DateTime.parse(json['event_date']),
      eventEndTime: TimeOfDay.fromDateTime(DateTime.parse("2000-01-01 ${json['event_end_time']}")),
      eventStartTime: TimeOfDay.fromDateTime(DateTime.parse("2000-01-01 ${json['event_start_time']}")),
      maxRegistrations: json['max_registrations'],
      name: json['name'],
      status: json['status'],
      donationUnit: DonationUnit.fromJson(json['donation_unit']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'current_registrations': currentRegistrations,
      'event_date': eventDate.toIso8601String(),
      'event_end_time': '${eventEndTime.hour.toString().padLeft(2, '0')}:${eventEndTime.minute.toString().padLeft(2, '0')}:00',
      'event_start_time': '${eventStartTime.hour.toString().padLeft(2, '0')}:${eventStartTime.minute.toString().padLeft(2, '0')}:00',
      'max_registrations': maxRegistrations,
      'name': name,
      'status': status,
      'donation_unit': donationUnit.toJson(),
    };
  }
}
