import 'package:challengesapp/application/common/length_constrained_input.dart';

class TaskInput extends LengthConstrainedInput {
  TaskInput.pure() : super.pure(minLength: 5);
  TaskInput.dirty({String value = ''})
      : super.dirty(minLength: 5, value: value);
}
