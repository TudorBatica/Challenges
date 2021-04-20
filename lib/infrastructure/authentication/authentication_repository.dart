import 'package:challengesapp/domain/authentication/user.dart';

/// Repository which manages user authentication.
abstract class AuthenticationRepository {
  Stream<User> get user;

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();
}
