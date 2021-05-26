import 'package:challengesapp/application/common/length_constrained_input.dart';

class TitleInput extends LengthConstrainedInput {
  TitleInput.pure() : super.pure(minLength: 5);
  TitleInput.dirty({String value = ''})
      : super.dirty(minLength: 5, value: value);
}
