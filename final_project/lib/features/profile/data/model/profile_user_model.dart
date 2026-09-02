class ProfileUserModel {
  const ProfileUserModel({
    required this.name,
    required this.email,
    required this.avatar,
  });

  final String name;
  final String email;
  final String avatar;

  factory ProfileUserModel.fromMap(
    Map<String, dynamic>? data, {
    required String fallbackName,
    required String fallbackEmail,
  }) {
    final name = data?['userName']?.toString();
    return ProfileUserModel(
      name: name == null || name.isEmpty ? fallbackName : name,
      email: data?['email']?.toString() ?? fallbackEmail,
      avatar: data?['avatar']?.toString() ?? '',
    );
  }
}
