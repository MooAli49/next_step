class JobRoleModel {
  final String id;
  final String label;

  JobRoleModel({required this.id, required this.label});

  factory JobRoleModel.fromJson(Map<String, dynamic> json) {
    return JobRoleModel(
      id: json['id'] as String,
      label: json['label'] as String,
    );
  }
}
