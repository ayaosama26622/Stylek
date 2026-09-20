import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/profile/domain/usecase/profile_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends ChangeNotifier {
  ProfileCubit(this._useCases);

  final ProfileUseCases _useCases;

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchCurrentUser() {
    return _useCases.watchCurrentUser();
  }

  String get displayName => _useCases.displayName;

  String get email => _useCases.email;

  Future<void> pickAndUploadImage(ImageSource source) {
    return _useCases.pickAndUploadImage(source);
  }

  Future<void> signOut() => _useCases.signOut();

  Future<void> updateName(String name) => _useCases.updateName(name);

  Future<void> updateEmail({
    required String newEmail,
    required String currentPassword,
  }) {
    return _useCases.updateEmail(
      newEmail: newEmail,
      currentPassword: currentPassword,
    );
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _useCases.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
