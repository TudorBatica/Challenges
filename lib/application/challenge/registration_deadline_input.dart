// ignore: public_member_api_docs
import 'package:formz/formz.dart';

enum RegistrationDeadlineInputError { invalid }

/// Registration deadline input whose value has to be
/// before the starting datetime and before the solution submission datetime
class RegistrationDeadlineInput
    extends FormzInput<DateTime, RegistrationDeadlineInputError> {
  RegistrationDeadlineInput.pure() : super.pure(DateTime.now()) {
    startingDatetime = DateTime.now();
    solutionSubmissionDateTime = DateTime.now();
  }

  /// Input has been touched by user
  RegistrationDeadlineInput.dirty(
      {required this.startingDatetime,
      required this.solutionSubmissionDateTime,
      required DateTime value})
      : super.dirty(value);

  /// Challenge starting date and time.
  late final DateTime startingDatetime;

  /// Challenge solution submission deadline.
  late final DateTime solutionSubmissionDateTime;

  @override
  RegistrationDeadlineInputError? validator(DateTime? value) {
    if (value == null ||
        startingDatetime.isBefore(value) ||
        solutionSubmissionDateTime.isBefore(value)) {
      return RegistrationDeadlineInputError.invalid;
    }
  }
}
