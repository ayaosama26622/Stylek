import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:final_project/core/functions/image_uploader.dart';
import 'package:final_project/features/profile/data/repo/profile_repo.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUseCases {
  ProfileUseCases(this._repo);

  final ProfileRepo _repo;

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchCurrentUser() {
    return _repo.watchCurrentUser();
  }

  String get displayName => _repo.displayName;

  String get email => _repo.email;

  Future<void> pickAndUploadImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(
      source: source,
      imageQuality: 75,
    );
    if (pickedImage == null) return;

    final imageUrl = await uploadImageToCloudinary(File(pickedImage.path));
    if (imageUrl == null) {
      throw Exception('edit_profile.image_upload_failed'.tr());
    }
    await _repo.updateAvatar(imageUrl);
  }

  Future<void> signOut() => _repo.signOut();

  Future<void> updateName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) throw Exception('edit_profile.name_required'.tr());
    return _repo.updateName(trimmed);
  }

  Future<void> updateEmail({
    required String newEmail,
    required String currentPassword,
  }) {
    final trimmed = newEmail.trim();
    if (trimmed.isEmpty || !trimmed.contains('@')) {
      throw Exception('auth.email_invalid'.tr());
    }
    if (currentPassword.isEmpty) {
      throw Exception('edit_profile.current_password_only_required'.tr());
    }
    return _repo.updateEmail(
      newEmail: trimmed,
      currentPassword: currentPassword,
    );
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    if (currentPassword.isEmpty) {
      throw Exception('edit_profile.current_password_only_required'.tr());
    }
    if (newPassword.length < 6) {
      throw Exception('auth.password_too_short'.tr());
    }
    return _repo.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
