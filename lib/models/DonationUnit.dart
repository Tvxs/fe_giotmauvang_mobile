class DonationUnit {
  final int id;
  final String? email;
  final String? location;
  final String? name;
  final String? phone;
  final String? unitPhotoUrl;

  DonationUnit({
    required this.id,
    this.email,
    this.location,
    this.name,
    this.phone,
    this.unitPhotoUrl,
  });

  factory DonationUnit.fromJson(Map<String, dynamic> json) {
    return DonationUnit(
      id: json['id'],
      email: json['email'],
      location: json['location'],
      name: json['name'],
      phone: json['phone'],
      unitPhotoUrl: json['unit_photo_url'],
    );
  }
  static DonationUnit defaultUnit() {
    return DonationUnit(
      id: 0,
      name: 'Unknown',
      email: '',
      location: 'Unknown location',
      phone: '',
      unitPhotoUrl: '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'location': location,
      'name': name,
      'phone': phone,
      'unit_photo_url': unitPhotoUrl,
    };
  }
}