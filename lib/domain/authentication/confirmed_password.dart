import 'package:formz/formz.dart';

// ignore: public_member_api_docs
enum ConfirmedPasswordValidationError { invalid }

// ignore: public_member_api_docs
class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');
  // ignore: public_member_api_docs
  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  // ignore: public_member_api_docs
  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String? value) {
    return password == value ? null : ConfirmedPasswordValidationError.invalid;
  }
}
