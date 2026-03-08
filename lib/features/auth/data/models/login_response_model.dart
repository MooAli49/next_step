class LoginResponseModel {
  String? id;
  String? token;
  String? name;
  String? email;
  bool? isCompleted;

  LoginResponseModel({
    this.id,
    this.token,
    this.name,
    this.email,
    this.isCompleted,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'] as String?,
      token: json['token'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      isCompleted: json['isCompleted'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'name': name,
      'email': email,
      'isCompleted': isCompleted,
    };
  }
}
