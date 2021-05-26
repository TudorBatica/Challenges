import '../common/length_constrained_input.dart';

/// Prize input for new challenge form
class PrizeInput extends LengthConstrainedInput {
  PrizeInput.pure() : super.pure(minLength: 1);
  // ignore: public_member_api_docs
  PrizeInput.dirty({String value = ''})
      : super.dirty(minLength: 1, value: value);
}
