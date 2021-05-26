import '../common/length_constrained_input.dart';

/// Description input
class DescriptionInput extends LengthConstrainedInput {
  DescriptionInput.pure() : super.pure(minLength: 10);
  // ignore: public_member_api_docs
  DescriptionInput.dirty({String value = ''})
      : super.dirty(minLength: 10, value: value);
}
