class UserInfo {
  final int id;
  final String? address;
  final DateTime? dob;
  final String? fullName;
  final String? sex;

  UserInfo({
    required this.id,
    this.address,
    this.dob,
    this.fullName,
    this.sex,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      address: json['address'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      fullName: json['full_name'],
      sex: json['sex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'dob': dob?.toIso8601String(),
      'full_name': fullName,
      'sex': sex,
    };
  }
}