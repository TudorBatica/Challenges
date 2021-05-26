// ignore: public_member_api_docs
import 'package:formz/formz.dart';

import '../../domain/common/pair.dart';

// ignore: public_member_api_docs
enum TeamSizeInputError { invalid }

/// Challenge team size input
class TeamSizeInput extends FormzInput<Pair<int, int>, TeamSizeInputError> {
  const TeamSizeInput.pure(Pair<int, int> value) : super.pure(value);

  /// Input has been modified by user
  const TeamSizeInput.dirty(Pair<int, int> value) : super.dirty(value);

  @override
  TeamSizeInputError? validator(Pair<int, int>? value) {
    if (value == null) {
      return TeamSizeInputError.invalid;
    }
    return value.first > value.second ? TeamSizeInputError.invalid : null;
  }
}
