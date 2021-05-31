import 'package:challengesapp/domain/teams/team_member.dart';
import 'package:formz/formz.dart';

import '../../domain/common/pair.dart';

// ignore: public_member_api_docs
enum MembersInputError { invalid }

/// Input with min/max number of chars allowed
class MembersInput extends FormzInput<List<TeamMember>, MembersInputError> {
  MembersInput.pure() : super.pure([]);

  // ignore: public_member_api_docs
  MembersInput.dirty({required List<TeamMember> value}) : super.dirty(value);

  @override
  MembersInputError? validator(List<TeamMember>? value) {
    return (value == null || value.isEmpty) ? MembersInputError.invalid : null;
  }
}
