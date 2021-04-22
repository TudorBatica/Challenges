import 'package:formz/formz.dart';

// ignore: public_member_api_docs
enum NameValidationError { invalid }

/// Name input model
class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');

  /// Input has been modified by the user
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String? value) {
    return ((value ?? '').trim().length > 1)
        ? null
        : NameValidationError.invalid;
  }
}
