import '../common/length_constrained_input.dart';

/// Title input
class TitleInput extends LengthConstrainedInput {
  TitleInput.pure() : super.pure(minLength: 5);
  // ignore: public_member_api_docs
  TitleInput.dirty({String value = ''})
      : super.dirty(minLength: 5, value: value);
}
