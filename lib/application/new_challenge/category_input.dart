import '../common/length_constrained_input.dart';

/// Category input for the new challenge form
class CategoryInput extends LengthConstrainedInput {
  CategoryInput.pure() : super.pure(minLength: 5);
  // ignore: public_member_api_docs
  CategoryInput.dirty({String value = ''})
      : super.dirty(minLength: 5, value: value);
}
