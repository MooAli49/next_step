class JobModel {
  String id;
  String? title;
  String? slug;
  String? description;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? addedAt;
  PostedBy? postedBy;
  bool? isFavorite; // Local field to track favorite status

  JobModel({
    required this.id,
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
    this.createdAt,
    this.updatedAt,
    this.addedAt,
    this.postedBy,
    this.isFavorite,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    final dynamic rawId = json['id'];
    String resolvedId;
    if (rawId is String) {
      resolvedId = rawId;
    } else {
      // If id is not a String (e.g., int), fall back to jobId
      final dynamic jobId = json['jobId'];
      resolvedId = jobId?.toString() ?? rawId.toString();
    }

    return JobModel(
      id: resolvedId,
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      location: json['location'],
      experience: json['experience'],
      jobType: json['jobType'],
      jobLevel: json['jobLevel'],
      salaryRange: json['salaryRange'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
      responsibilities: json['responsibilities'] != null
          ? List<String>.from(json['responsibilities'])
          : null,
      requirements: json['requirements'] != null
          ? List<String>.from(json['requirements'])
          : null,
      benefits: json['benefits'] != null
          ? List<String>.from(json['benefits'])
          : null,
      postedById: json['postedById'],
      postedBy: json['postedBy'] != null
          ? PostedBy.fromJson(json['postedBy'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      addedAt: json['addedAt'] != null ? DateTime.parse(json['addedAt']) : null,
      isFavorite: json['isFavorite'],
    );
  }
}

class PostedBy {
  String? id;
  String? fullName;
  String? email;
  String? role;
  String? imageUrl;

  PostedBy({this.id, this.fullName, this.email, this.role, this.imageUrl});

  factory PostedBy.fromJson(Map<String, dynamic> json) {
    return PostedBy(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'],
      imageUrl: json['imageUrl'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'role': role,
      'imageUrl': imageUrl,
    };
  }
}
