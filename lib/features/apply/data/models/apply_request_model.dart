class ApplyRequestModel {
  final String jobId;
  final String resumeUrl;
  final String? coverLetter;

  ApplyRequestModel({
    required this.jobId,
    required this.resumeUrl,
    this.coverLetter,
  });

  Map<String, dynamic> toJson() {
    return {'jobId': jobId, 'resumeUrl': resumeUrl, 'coverLetter': coverLetter};
  }
}
