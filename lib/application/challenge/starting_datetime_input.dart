// ignore: public_member_api_docs
import 'package:formz/formz.dart';

// ignore: public_member_api_docs
enum StartingDatetimeInputError { invalid }

/// Starting datetime input whose value has to be
/// after the registration deadline and before the solution submission datetime
class StartingDatetimeInput
    extends FormzInput<DateTime, StartingDatetimeInputError> {
  StartingDatetimeInput.pure() : super.pure(DateTime.now()) {
    registrationDeadline = DateTime.now();
    solutionSubmissionDateTime = DateTime.now();
  }

  /// Input has been touched by user
  StartingDatetimeInput.dirty(
      {required this.registrationDeadline,
      required this.solutionSubmissionDateTime,
      required DateTime value})
      : super.dirty(value);

  /// Challenge registration deadline.
  late final DateTime registrationDeadline;

  /// Challenge solution submission deadline.
  late final DateTime solutionSubmissionDateTime;

  @override
  StartingDatetimeInputError? validator(DateTime? value) {
    if (value == null ||
        registrationDeadline.isAfter(value) ||
        solutionSubmissionDateTime.isBefore(value)) {
      return StartingDatetimeInputError.invalid;
    }
  }
}
