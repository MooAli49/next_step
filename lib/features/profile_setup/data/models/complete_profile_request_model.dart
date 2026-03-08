class CompleteProfileRequestModel {
  String? imageUrl;
  List<String>? jobRoles;
  List<String>? countries;

  CompleteProfileRequestModel({this.imageUrl, this.jobRoles, this.countries});

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'jobRoles': jobRoles,
    'countries': countries,
  };
}
