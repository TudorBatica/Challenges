import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import 'authentication_failures.dart';
import 'authentication_repository.dart';

/// Authentication Repository implementation
/// which makes use of FirebaseAuth services.
@LazySingleton(as: AuthenticationRepository)
class FirebaseAuthRepository implements AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw SignInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      _handleSignUpException(e);
    }
  }

  void _handleSignUpException(firebase_auth.FirebaseAuthException exception) {
    switch (exception.code.toUpperCase()) {
      case "EMAIL-ALREADY-IN-USE":
        throw EmailAlreadyInUseFailure();
      default:
        throw SignUpWithEmailAndPasswordFailure();
    }
  }
}
