class RegisterRequestModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;
  final String gender;
  final String role;
  final String password;

  RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.address,
    required this.gender,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'address': address,
      'gender': gender,
      'role': role,
    };
  }

  @override
  String toString() {
    return 'RegisterRequestModel{fullName: $fullName, email: $email, phoneNumber: $phoneNumber, password: $password, address: $address, gender: $gender, role: $role}';
  }
}
