import 'package:challengesapp/domain/profile/profile_repository.dart';
import 'package:challengesapp/domain/profile/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../domain/authentication/authentication_repository.dart';
import '../../domain/authentication/user_identity.dart';
import '../../domain/authentication/authentication_failures.dart';

/// Authentication Repository implementation
/// which makes use of FirebaseAuth services.
@LazySingleton(as: AuthenticationRepository)
class FirebaseAuthRepository implements AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final ProfileRepository _profileRepository;

  // ignore: public_member_api_docs
  FirebaseAuthRepository(this._firebaseAuth, this._profileRepository);

  @override
  Stream<UserIdentity> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? UserIdentity.anonymous
          : firebaseUser.toUser;
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
      {required String email,
      required String password,
      required String name}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _profileRepository.createNewUserProfile(
          userCredential.user!.uid, UserProfile(name: name));
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
  UserIdentity get toUser => UserIdentity(id: uid, email: email);
}
