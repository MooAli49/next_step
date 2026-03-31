/*
 
  "job": {
  "id": "611efcaa-464c-46c8-8465-2f007f727220",
  "title": "Customer Service Representative",
  "postedBy": {
  "id": "550e8400-e29b-41d4-a716-446655440003",
  "fullName": "Carol Chen",
  "email": "recruiter2@nextstep.com",
  "role": "RECRUITER",
  "imageUrl": "https://n9typqfrnexj4eg9.public.blob.vercel-storage.com/Canadian%20TikToker%20@emily.the.recruiter%20Emily%20Durham-LeuWAf1qKsgESF1g3STRLJGaPzitSI.png"
  }
  }
  },
*/
import 'package:next_step/features/jobs/data/models/job_model.dart';

class UserApplicationJobModel {
  String id;
  String jobId;
  String applicantId;
  String? coverLetter;
  String? resumeUrl;
  String? status;
  DateTime? appliedAt;
  JobInfo? jobInfo;
  Applicant? applicant;

  UserApplicationJobModel({
    required this.id,
    required this.jobId,
    required this.applicantId,
    this.resumeUrl,
    this.coverLetter,
    this.status,
    this.jobInfo,
    this.applicant,
    this.appliedAt,
  });

  factory UserApplicationJobModel.fromJson(Map<String, dynamic> json) {
    return UserApplicationJobModel(
      id: json['id'],
      jobId: json['jobId'],
      applicantId: json['applicantId'],
      resumeUrl: json['resumeUrl'],
      coverLetter: json['coverLetter'],
      status: json['status'],
      jobInfo: json['job'] != null ? JobInfo.fromJson(json['job']) : null,
      applicant: json['applicant'] != null
          ? Applicant.fromJson(json['applicant'])
          : null,
      appliedAt: json['appliedAt'] != null
          ? DateTime.parse(json['appliedAt'])
          : null,
    );
  }
}

class JobInfo {
  String id;
  String title;
  PostedBy? postedBy;

  JobInfo({required this.id, required this.title, this.postedBy});

  factory JobInfo.fromJson(Map<String, dynamic> json) {
    return JobInfo(
      id: json['id'],
      title: json['title'],
      postedBy: json['postedBy'] != null
          ? PostedBy.fromJson(json['postedBy'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'postedBy': postedBy?.toJson()};
  }
}

class Applicant {
  String id;
  String fullName;
  String email;

  Applicant({required this.id, required this.fullName, required this.email});

  factory Applicant.fromJson(Map<String, dynamic> json) {
    return Applicant(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'fullName': fullName, 'email': email};
  }
}
