import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../domain/profile/profile_repository.dart';
import '../../domain/profile/user_profile.dart';
import '../common/database_naming.dart';

/// ProfileRepository implementation which uses the Firebase Firestore service.
@LazySingleton(as: ProfileRepository)
class FirestoreProfileRepository extends ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;
  late final CollectionReference _userProfiles;

  // ignore: public_member_api_docs
  FirestoreProfileRepository(this._firebaseFirestore) {
    _userProfiles = _firebaseFirestore.collection(userProfilesCollectionPath);
  }

  @override
  Future<void> createNewUserProfile(String id, UserProfile profile) async {
    await _userProfiles.doc(id).set(profile.toJson());
  }
}
