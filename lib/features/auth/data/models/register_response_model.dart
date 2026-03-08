class RegisterResponseModel {
  String? email;
  String? fullName;
  String? phoneNumber;
  String? address;
  String? password;
  String? gender;
  String? role;

  RegisterResponseModel({
    this.email,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.password,
    this.gender,
    this.role,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      password: json['password'] as String?,
      gender: json['gender'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'address': address,
    'password': password,
    'gender': gender,
    'role': role,
  };
}
