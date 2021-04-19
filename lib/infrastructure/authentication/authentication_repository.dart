/// Repository which manages user authentication.
abstract class AuthenticationRepository {
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password});
}
