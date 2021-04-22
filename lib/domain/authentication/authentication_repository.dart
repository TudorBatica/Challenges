import 'user_identity.dart';

/// Repository which manages user authentication.
abstract class AuthenticationRepository {
  /// Stream which emits a new user each time the logged in user changes.
  /// Emits `User.anonymous` when no user is logged in.
  Stream<UserIdentity> get user;

  /// Handles login
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});

  /// Handles registration
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password});

  /// Handles logout
  Future<void> signOut();
}
