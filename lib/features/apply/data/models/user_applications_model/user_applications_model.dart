import 'job.dart';

class UserApplicationsModel {
  String? id;
  String? jobId;
  String? applicantId;
  String? coverLetter;
  String? resumeUrl;
  String? status;
  DateTime? appliedAt;
  Job? job;

  UserApplicationsModel({
    this.id,
    this.jobId,
    this.applicantId,
    this.coverLetter,
    this.resumeUrl,
    this.status,
    this.appliedAt,
    this.job,
  });

  factory UserApplicationsModel.fromJson(Map<String, dynamic> json) {
    return UserApplicationsModel(
      id: json['id'] as String?,
      jobId: json['jobId'] as String?,
      applicantId: json['applicantId'] as String?,
      coverLetter: json['coverLetter'] as String?,
      resumeUrl: json['resumeUrl'] as String?,
      status: json['status'] as String?,
      appliedAt: json['appliedAt'] == null
          ? null
          : DateTime.parse(json['appliedAt'] as String),
      job: json['job'] == null
          ? null
          : Job.fromJson(json['job'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'jobId': jobId,
    'applicantId': applicantId,
    'coverLetter': coverLetter,
    'resumeUrl': resumeUrl,
    'status': status,
    'appliedAt': appliedAt?.toIso8601String(),
    'job': job?.toJson(),
  };
}
