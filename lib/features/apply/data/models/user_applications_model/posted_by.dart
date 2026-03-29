class PostedBy {
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? imageUrl;

  PostedBy({this.id, this.fullName, this.email, this.role, this.imageUrl});

  factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
    id: json['id'] as String?,
    fullName: json['fullName'] as String?,
    email: json['email'] as String?,
    role: json['role'] as String?,
    imageUrl: json['imageUrl'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'email': email,
    'role': role,
    'imageUrl': imageUrl,
  };
}
