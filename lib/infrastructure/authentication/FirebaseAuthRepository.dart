import 'package:challengesapp/infrastructure/authentication/AuthenticationRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithEmailAndPasswordException implements Exception {}

class FirebaseAuthRepository implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);

  @override
  Future<void> signInWithEmailAndPassword() {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }
}
