class TotalJobs {
  int? fullTime;
  int? partTime;
  int? freelance;

  TotalJobs({this.fullTime, this.partTime, this.freelance});

  factory TotalJobs.fromJson(Map<String, dynamic> json) => TotalJobs(
    fullTime: json['fullTime'] as int?,
    partTime: json['partTime'] as int?,
    freelance: json['freelance'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'fullTime': fullTime,
    'partTime': partTime,
    'freelance': freelance,
  };
}
