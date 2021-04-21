import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../domain/authentication/authentication_repository.dart';
import '../../domain/authentication/user.dart';
import 'authentication_failures.dart';

/// Authentication Repository implementation
/// which makes use of FirebaseAuth services.
@LazySingleton(as: AuthenticationRepository)
class FirebaseAuthRepository implements AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// Constructor
  FirebaseAuthRepository(this._firebaseAuth);

  @override
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.anonymous : firebaseUser.toUser;
    });
  }

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
    } on Exception {
      throw SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception {
      throw SignOutFailure();
    }
  }
}

/// Maps Firebase user to domain user
extension on firebase_auth.User {
  User get toUser =>
      User(id: uid, email: email, name: displayName, profilePicture: photoURL);
}
