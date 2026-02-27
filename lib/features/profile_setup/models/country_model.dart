class CountryModel {
  final String name;
  final String code;

  CountryModel({required this.name, required this.code});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'] as String,
      code: json['code'] as String,
    );
  }
}
