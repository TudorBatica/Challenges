import '../common/length_constrained_input.dart';

/// Task input for the new challenge form
class TaskInput extends LengthConstrainedInput {
  TaskInput.pure() : super.pure(minLength: 5);
  // ignore: public_member_api_docs
  TaskInput.dirty({String value = ''})
      : super.dirty(minLength: 5, value: value);
}
