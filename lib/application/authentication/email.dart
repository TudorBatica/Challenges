import 'package:formz/formz.dart';

// ignore: public_member_api_docs
enum EmailValidationError { invalid }

/// Email input model
class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  /// Input has been modified by the user
  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}
