import '../common/length_constrained_input.dart';

/// Team name input
class TeamNameInput extends LengthConstrainedInput {
  TeamNameInput.pure() : super.pure(minLength: 1);
  // ignore: public_member_api_docs
  TeamNameInput.dirty({String value = ''})
      : super.dirty(minLength: 1, value: value);
}
