import '../common/length_constrained_input.dart';

class DescriptionInput extends LengthConstrainedInput {
  DescriptionInput.pure() : super.pure(minLength: 10);
  DescriptionInput.dirty({String value = ''})
      : super.dirty(minLength: 10, value: value);
}
