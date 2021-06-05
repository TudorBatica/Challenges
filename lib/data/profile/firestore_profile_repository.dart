import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../domain/common/json_serializer.dart';
import '../../domain/profile/profile_repository.dart';
import '../../domain/profile/user_profile.dart';
import '../common/database_naming.dart';
import '../common/firestore_crud_repository.dart';

/// ProfileRepository implementation which uses the Firebase Firestore service.
@LazySingleton(as: ProfileRepository)
class FirestoreProfileRepository extends FirestoreCrudRepository<UserProfile>
    implements ProfileRepository {
  // ignore: public_member_api_docs
  FirestoreProfileRepository(FirebaseFirestore firebaseFirestore,
      JsonSerializer<UserProfile> serializer)
      : super(firebaseFirestore, serializer, userProfilesCollectionPath);

  @override
  Future<void> createNewUserProfile(String id, UserProfile profile) async {
    await create(profile, id);
  }

  @override
  Future<UserProfile> getUserProfile(String id) async {
    return read(id);
  }

  @override
  Future<void> updateUserProfile(
      Map<String, dynamic> updatedFields, String id) {
    return update(updatedFields, id);
  }
}
