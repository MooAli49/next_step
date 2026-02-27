class RegisterRequestModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });
  @override
  String toString() {
    return 'RegisterRequestModel{name: $name, email: $email, phoneNumber: $phoneNumber, password: $password}';
  }
}
