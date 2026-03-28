class UserModel {
  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  String? gender;
  List<String>? jobRoles;
  String? role;
  List<String>? countries;
  String? imageUrl;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
    this.gender,
    this.jobRoles,
    this.role,
    this.countries,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      gender: json['gender'] as String?,
      jobRoles: (json['jobRoles'] as List<dynamic>?)?.cast<String>(),
      role: json['role'] as String?,
      countries: (json['countries'] as List<dynamic>?)?.cast<String>(),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'email': email,
    'phoneNumber': phoneNumber,
    'address': address,
    'gender': gender,
    'jobRoles': jobRoles,
    'role': role,
    'countries': countries,
    'imageUrl': imageUrl,
  };

  @override
  String toString() {
    return 'UserModel{id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, address: $address, gender: $gender, jobRoles: $jobRoles, role: $role, countries: $countries, imageUrl: $imageUrl}';
  }
}
