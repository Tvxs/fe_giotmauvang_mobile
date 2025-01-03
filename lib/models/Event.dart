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
  final String? status;
  final DonationUnit donationUnitDTO;  // Changed from donationUnitId

  Event({
    required this.id,
    this.currentRegistrations,
    required this.eventDate,
    required this.eventEndTime,
    required this.eventStartTime,
    this.maxRegistrations,
    this.name,
    required this.status,
    required this.donationUnitDTO,
  });

  factory Event.fromJson(Map<String, dynamic> json) {

    var donationUnitDTOJson = json['donationUnitDTO'];
    DonationUnit donationUnitDTO;

    // Nếu donationUnitDTO là Map, ta tiếp tục xử lý
    if (donationUnitDTOJson != null && donationUnitDTOJson is Map<String, dynamic>) {
      donationUnitDTO = DonationUnit.fromJson(donationUnitDTOJson);
    } else {
      // Nếu không có giá trị hợp lệ, trả về một đối tượng mặc định hoặc null
      donationUnitDTO = DonationUnit.defaultUnit();
    }

    return Event(
      id: json['id'],
      currentRegistrations: json['currentRegistrations'],
      eventDate: DateTime.parse(json['eventDate']),
      eventEndTime: TimeOfDay.fromDateTime(DateTime.parse("2000-01-01 ${json['eventEndTime']}")),
      eventStartTime: TimeOfDay.fromDateTime(DateTime.parse("2000-01-01 ${json['eventStartTime']}")),
      maxRegistrations: json['maxRegistrations'],
      name: json['name'],
      status: json['status'] ?? 'unknown',
      donationUnitDTO: donationUnitDTO
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
      'donation_unit': donationUnitDTO.toJson(),
    };
  }
}
