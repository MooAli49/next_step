class UpdateProfileRequestModel {
  final String? email;
  final String? fullName;
  final String? phoneNumber;
  final String? address;
  final String? gender;
  final String? imageUrl;

  UpdateProfileRequestModel({
    this.email,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.gender,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    if (email != null) 'email': email,
    if (fullName != null) 'fullName': fullName,
    if (phoneNumber != null) 'phoneNumber': phoneNumber,
    if (address != null) 'address': address,
    if (gender != null) 'gender': gender,
    if (imageUrl != null) 'imageUrl': imageUrl,
  };
}
