import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

/// Module used for injecting Firebase third party dependency
@module
abstract class FirebaseInjectableModule {
  /// Retrieves the FirebaseAuth service instance
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
