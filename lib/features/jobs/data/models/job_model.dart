class JobModel {
  String? id;
  String? title;
  String? description;
  String? slug;
  String? location;
  String? experience;
  String? jobType;
  String? jobLevel;
  String? salaryRange;
  List<String>? skills;
  List<String>? responsibilities;
  List<String>? requirements;
  List<String>? benefits;
  String? postedById;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  PostedBy? postedBy;
  JobCategory? category;
  bool? isFavorite;

  JobModel({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.location,
    this.experience,
    this.jobType,
    this.jobLevel,
    this.salaryRange,
    this.skills,
    this.responsibilities,
    this.requirements,
    this.benefits,
    this.postedById,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.postedBy,
    this.category,
    this.isFavorite,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id']?.toString(),
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      experience: json['experience'] as String?,
      jobType: json['jobType'] as String?,
      jobLevel: json['jobLevel'] as String?,
      salaryRange: json['salaryRange'] as String?,
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      responsibilities: (json['responsibilities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      requirements: (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      benefits: (json['benefits'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      postedById: json['postedById'] as String?,
      categoryId: json['categoryId'] as int?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      postedBy: json['postedBy'] != null
          ? PostedBy.fromJson(json['postedBy'] as Map<String, dynamic>)
          : null,
      isFavorite: json['isFavorite'] as bool?,
      category: json['category'] != null
          ? JobCategory.fromJson(json['category'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'location': location,
      'experience': experience,
      'jobType': jobType,
      'jobLevel': jobLevel,
      'salaryRange': salaryRange,
      'skills': skills,
      'responsibilities': responsibilities,
      'requirements': requirements,
      'benefits': benefits,
      'postedById': postedById,
      'categoryId': categoryId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'postedBy': postedBy?.toJson(),
      'isFavorite': isFavorite,
      'category': category?.toJson(),
    };
  }
}

class PostedBy {
  final String? id;
  final String? fullName;
  final String? email;
  final String? imageUrl;
  final String? role;

  PostedBy({this.id, this.fullName, this.email, this.imageUrl, this.role});

  factory PostedBy.fromJson(Map<String, dynamic> json) {
    return PostedBy(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      imageUrl: json['imageUrl'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'imageUrl': imageUrl,
      'role': role,
    };
  }
}

class JobCategory {
  final int? id;
  final String? name;
  final String? description;

  JobCategory({this.id, this.name, this.description});

  factory JobCategory.fromJson(Map<String, dynamic> json) {
    return JobCategory(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
