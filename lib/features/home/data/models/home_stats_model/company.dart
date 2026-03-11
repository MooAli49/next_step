class Company {
  String? id;
  String? fullName;
  String? imageUrl;

  Company({this.id, this.fullName, this.imageUrl});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json['id'] as String?,
    fullName: json['fullName'] as String?,
    imageUrl: json['imageUrl'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'imageUrl': imageUrl,
  };
}
