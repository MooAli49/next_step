import 'company.dart';

class SuggestedJob {
  String? id;
  String? title;
  Company? company;
  String? location;
  String? jobType;
  String? jobLevel;
  String? salaryRange;
  DateTime? createdAt;

  SuggestedJob({
    this.id,
    this.title,
    this.company,
    this.location,
    this.jobType,
    this.jobLevel,
    this.salaryRange,
    this.createdAt,
  });

  factory SuggestedJob.fromJson(Map<String, dynamic> json) => SuggestedJob(
    id: json['id'] as String?,
    title: json['title'] as String?,
    company: json['company'] == null
        ? null
        : Company.fromJson(json['company'] as Map<String, dynamic>),
    location: json['location'] as String?,
    jobType: json['jobType'] as String?,
    jobLevel: json['jobLevel'] as String?,
    salaryRange: json['salaryRange'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'company': company?.toJson(),
    'location': location,
    'jobType': jobType,
    'jobLevel': jobLevel,
    'salaryRange': salaryRange,
    'createdAt': createdAt?.toIso8601String(),
  };
}
