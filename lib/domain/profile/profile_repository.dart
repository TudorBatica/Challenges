import 'user_profile.dart';

/// Repository which manages user profiles
abstract class ProfileRepository {
  /// Store a new user profile
  Future<void> createNewUserProfile(String id, UserProfile profile);

  /// Retrieves a user profile
  Future<UserProfile> getUserProfile(String id);

  /// Update specific fields of the profile
  Future<void> updateUserProfile(Map<String, dynamic> updatedFields, String id);
}
