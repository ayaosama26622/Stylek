import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/core/services/firebase/firestore_provider.dart';

class ProfileRepo {
  Stream<DocumentSnapshot<Map<String, dynamic>>> watchCurrentUser() {
    return FirebaseProvider.currentUserStream();
  }

  String get displayName => FirebaseProvider.currentUser?.displayName ?? '';

  String get email => FirebaseProvider.currentUser?.email ?? '';

  Future<void> updateAvatar(String imageUrl) {
    return FirebaseProvider.updateCurrentUserAvatar(imageUrl);
  }

  Future<void> updateName(String name) {
    return FirebaseProvider.updateCurrentUserName(name);
  }

  Future<void> updateEmail({
    required String newEmail,
    required String currentPassword,
  }) {
    return FirebaseProvider.updateCurrentUserEmail(
      newEmail: newEmail,
      currentPassword: currentPassword,
    );
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return FirebaseProvider.updateCurrentUserPassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  Future<void> signOut() => FirebaseProvider.signOut();
}
