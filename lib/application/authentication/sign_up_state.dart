part of 'sign_up_cubit.dart';

/// Sign up form representation
@immutable
class SignUpState extends Equatable {
  /// form email
  final Email email;

  /// form name
  final Name name;

  /// form password
  final Password password;

  /// form password confirmation
  final ConfirmedPassword confirmedPassword;

  /// current form status
  final FormzStatus status;

  /// constructor
  const SignUpState(
      {this.email = const Email.pure(),
      this.name = const Name.pure(),
      this.password = const Password.pure(),
      this.confirmedPassword = const ConfirmedPassword.pure(),
      this.status = FormzStatus.pure});

  @override
  List<Object?> get props => [email, name, password, confirmedPassword, status];

  /// copy factory
  SignUpState copyWith({
    Email? email,
    Name? name,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
    );
  }
}
