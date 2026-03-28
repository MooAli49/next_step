import 'suggested_job.dart';
import 'total_jobs.dart';

class HomeStatsModel {
  TotalJobs? totalJobs;
  List<SuggestedJob>? suggestedJobs;

  HomeStatsModel({this.totalJobs, this.suggestedJobs});

  factory HomeStatsModel.fromJson(Map<String, dynamic> json) {
    return HomeStatsModel(
      totalJobs: json['totalJobs'] == null
          ? null
          : TotalJobs.fromJson(json['totalJobs'] as Map<String, dynamic>),
      suggestedJobs: (json['suggestedJobs'] as List<dynamic>?)
          ?.map((e) => SuggestedJob.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'totalJobs': totalJobs?.toJson(),
    'suggestedJobs': suggestedJobs?.map((e) => e.toJson()).toList(),
  };
}
