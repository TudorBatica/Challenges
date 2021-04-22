import 'package:challengesapp/domain/profile/user_profile.dart';

/// Repository which manages user profiles
abstract class ProfileRepository {
  /// Create and store a new user profile
  Future<void> createNewUserProfile(String id, UserProfile profile);
}
