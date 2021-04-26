import 'user_profile.dart';

/// Repository which manages user profiles
abstract class ProfileRepository {
  /// Store a new user profile
  Future<void> createNewUserProfile(String id, UserProfile profile);

  /// Retrieves a user profile
  Future<UserProfile> getUserProfile(String id);
}
