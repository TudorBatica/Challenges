import 'package:challengesapp/application/common/length_constrained_input.dart';

class PrizeInput extends LengthConstrainedInput {
  PrizeInput.pure() : super.pure(minLength: 1);
  PrizeInput.dirty({String value = ''})
      : super.dirty(minLength: 1, value: value);
}
