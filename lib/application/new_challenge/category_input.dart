import '../common/length_constrained_input.dart';

class CategoryInput extends LengthConstrainedInput {
  CategoryInput.pure() : super.pure(minLength: 5);
  CategoryInput.dirty({String value = ''})
      : super.dirty(minLength: 5, value: value);
}
