part of 'sign_in_cubit.dart';

@immutable
class SignInState {
  const SignInState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});

  final Email email;
  final Password password;
  final FormzStatus status;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignInState &&
        other.email == email &&
        other.password == password &&
        other.status == status;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ status.hashCode;

  SignInState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
