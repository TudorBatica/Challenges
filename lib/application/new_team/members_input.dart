import 'package:formz/formz.dart';

import '../../domain/common/pair.dart';

// ignore: public_member_api_docs
enum MembersInputError { invalid }

/// Input with min/max number of chars allowed
class MembersInput
    extends FormzInput<List<Pair<String, String>>, MembersInputError> {
  MembersInput.pure() : super.pure([]);

  // ignore: public_member_api_docs
  MembersInput.dirty({required List<Pair<String, String>> value})
      : super.dirty(value);

  @override
  MembersInputError? validator(List<Pair<String, String>>? value) {
    return (value == null || value.isEmpty) ? MembersInputError.invalid : null;
  }
}
