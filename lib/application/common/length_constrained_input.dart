import 'package:formz/formz.dart';

// ignore: public_member_api_docs
enum LengthConstrainedInputError { invalid }

/// Input with min/max number of chars allowed
class LengthConstrainedInput
    extends FormzInput<String, LengthConstrainedInputError> {
  /// Min number of chars
  final int? minLength;

  /// Max number of chars
  final int? maxLength;

  LengthConstrainedInput.pure({this.minLength, this.maxLength})
      : super.pure('');

  // ignore: public_member_api_docs
  LengthConstrainedInput.dirty(
      {this.minLength, this.maxLength, String value = ''})
      : super.dirty(value);

  @override
  LengthConstrainedInputError? validator(String? value) {
    final valueString = value ?? '';
    if (minLength != null && valueString.length < minLength!.toInt()) {
      return LengthConstrainedInputError.invalid;
    }
    if (maxLength != null && valueString.length > maxLength!.toInt()) {
      return LengthConstrainedInputError.invalid;
    }
  }
}
