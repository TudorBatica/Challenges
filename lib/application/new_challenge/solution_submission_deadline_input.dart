// ignore: public_member_api_docs
import 'package:formz/formz.dart';

// ignore: public_member_api_docs
enum SolutionSubmissionDeadlineInputError { invalid }

/// Solution submission deadline input whose value has to be
/// after the registration deadline and after the solution submission datetime
class SolutionSubmissionDeadlineInput
    extends FormzInput<DateTime, SolutionSubmissionDeadlineInputError> {
  SolutionSubmissionDeadlineInput.pure() : super.pure(DateTime.now()) {
    registrationDeadline = DateTime.now();
    startingDatetime = DateTime.now();
  }

  /// Input has been touched by user
  SolutionSubmissionDeadlineInput.dirty(
      {required this.registrationDeadline,
      required this.startingDatetime,
      required DateTime value})
      : super.dirty(value);

  /// Challenge registration deadline.
  late final DateTime registrationDeadline;

  /// Challenge starting datetime.
  late final DateTime startingDatetime;

  @override
  SolutionSubmissionDeadlineInputError? validator(DateTime? value) {
    print("\nIn solution datetime validator");
    print(
        'value is $value\nregistration is $registrationDeadline\nstart is $startingDatetime');
    if (value == null ||
        registrationDeadline.isAfter(value) ||
        startingDatetime.isAfter(value)) {
      return SolutionSubmissionDeadlineInputError.invalid;
    }
  }
}
