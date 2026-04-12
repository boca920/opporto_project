class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String? about;
  final String? industry;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.about,
    this.industry,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      about: json['about']?.toString(),
      industry: json['industry']?.toString(),
      profileImage: json['image']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'about': about,
      'industry': industry,
    };
  }

  UserModel copyWith({
    String? name,
    String? phone,
    String? about,
    String? industry,
    String? profileImage,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email,
      phone: phone ?? this.phone,
      role: role,
      about: about ?? this.about,
      industry: industry ?? this.industry,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}