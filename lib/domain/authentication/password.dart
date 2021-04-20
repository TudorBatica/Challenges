// ignore: import_of_legacy_library_into_null_safe
import 'package:formz/formz.dart';

// ignore: public_member_api_docs
enum PasswordValidationError { invalid }

// ignore: public_member_api_docs
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  // ignore: public_member_api_docs
  const Password.dirty([String value = '']) : super.dirty(value);

  /// At least 8 characters in total with at least 1 letter,
  /// at least 1 number and at least 1 special character.
  static final _passwordRegExp =
      RegExp(r"^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}
