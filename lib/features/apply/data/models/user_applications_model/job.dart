import 'posted_by.dart';

class Job {
  String? id;
  String? title;
  PostedBy? postedBy;

  Job({this.id, this.title, this.postedBy});

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json['id'] as String?,
    title: json['title'] as String?,
    postedBy: json['postedBy'] == null
        ? null
        : PostedBy.fromJson(json['postedBy'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'postedBy': postedBy?.toJson(),
  };
}
