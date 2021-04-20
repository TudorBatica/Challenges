abstract class AuthenticationFailure implements Exception {
  final String messageForUser;

  AuthenticationFailure(String this.messageForUser);
}

class SignInWithEmailAndPasswordFailure extends AuthenticationFailure {
  SignInWithEmailAndPasswordFailure()
      : super("Sign in failed. Please, try again.");
}

class SignUpWithEmailAndPasswordFailure extends AuthenticationFailure {
  SignUpWithEmailAndPasswordFailure()
      : super("Sign up failed. Please, try again.");
}

class EmailAlreadyInUseFailure extends AuthenticationFailure {
  EmailAlreadyInUseFailure() : super("This email is already in use");
}
