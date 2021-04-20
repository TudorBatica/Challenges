part of 'sign_in_cubit.dart';

/// Sign in form state representation
@immutable
class SignInState extends Equatable {
  /// Constructor
  const SignInState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});

  /// form email
  final Email email;

  /// form password
  final Password password;

  /// form current status
  final FormzStatus status;

  @override
  List<Object?> get props => [email, password, status];

  /// copy factory
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
