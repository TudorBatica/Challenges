import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import '../../domain/authentication/authentication_failures.dart';
import '../../domain/authentication/authentication_repository.dart';
import '../../domain/authentication/user_identity.dart';
import '../../domain/common/user.dart';
import '../../domain/profile/profile_repository.dart';
import '../../domain/profile/user_profile.dart';

/// Authentication Repository implementation
/// which makes use of FirebaseAuth services.
@LazySingleton(as: AuthenticationRepository)
class FirebaseAuthRepository implements AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final ProfileRepository _profileRepository;

  // ignore: public_member_api_docs
  FirebaseAuthRepository(this._firebaseAuth, this._profileRepository);

  @override
  Stream<User> get user async* {
    await for (var firebaseUser in _firebaseAuth.authStateChanges()) {
      if (firebaseUser == null) {
        yield User(identity: UserIdentity.anonymous);
      } else {
        final profile =
            await _profileRepository.getUserProfile(firebaseUser.uid);
        yield User(identity: firebaseUser.toUserIdentity, profile: profile);
      }
    }
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

/// Maps Firebase user to [UserIdentity]
extension on firebase_auth.User {
  UserIdentity get toUserIdentity =>
      UserIdentity(id: uid, email: email, isConfirmed: emailVerified);
}
