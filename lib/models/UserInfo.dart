class UserInfo {
  final int id;
  final String? address;
  final String? dob;
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
      dob: json['dob'] ,
      fullName: json['full_name'],
      sex: json['sex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'dob': dob,
      'full_name': fullName,
      'sex': sex,
    };
  }
}